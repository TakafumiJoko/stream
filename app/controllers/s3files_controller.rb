class S3filesController < ApplicationController
  
  skip_before_action :check_logged_in, only: [:home]

  def new
    @s3file = S3file.new()
    @categories = S3file.categories.to_a
    @channels = current_user.channels
  end
  
  def create
    
    file = s3file_params[:key]
    filename = file.original_filename
    file_path = "tmp/#{filename}"
    File.binwrite(file_path, file.read)
    
    S3file.create(key: filename, category: s3file_params[:category], channel_id: s3file_params[:channel_id])
    @s3file = S3file.last

    bucket = @s3.bucket(@bucketname)
    object = bucket.object("assets#{@s3file.id.to_s}/#{filename}")
    object.upload_file(file_path, acl: 'public-read')
    
    file = s3file_params[:image]
    filename = file.original_filename
    file_path = "tmp/#{filename}"
    File.binwrite(file_path, file.read)
    
    @s3file.update_attribute(:image, filename)
    
    object = bucket.object("assets#{@s3file.id.to_s}/#{filename}")
    object.upload_file(file_path, acl: 'public-read')
    
    redirect_to @s3file
  end
  
  def index
    
  end

  def show
    @s3file = S3file.find(params[:id])
    @s3file.histories.create(user_id: current_user.id)
    View.count_view(@s3file)
    if view = OneDayView.find_by(s3file_id: @s3file.id)
      count = view.count + 1
      view.update_attribute(:count, count)
    else
      OneDayView.create(s3file_id: @s3file.id, count: 0)
    end
  end
  
  def initialize
    super
    @region = 'ap-northeast-1'
    @bucketname = 'bucket-for-stream'
    @s3 = get_s3_resource
  end
  
  def home
    @s3files = S3file.all
    @trend = S3file.joins(:one_day_view).order(count: :desc).limit(10)
  end
  
  def music
    @s3files = S3file.where(category: "music")
  end
  
  def movie
    @s3files = S3file.where(category: "movie")
  end
  
  def program
    @s3files = S3file.where(category: "program")
  end
  
  def game
    @s3files = S3file.where(category: "game")
  end
  
  def news
    @s3files = S3file.where(category: "news")
  end
  
  def sports
    @s3files = S3file.where(category: "sports")
  end
  
  def learning
    @s3files = S3file.where(category: "learning")
  end
  
  def search
    if params[:key]
      @s3files = S3file.where(key: params[:key])
    else params[:category]
      @s3files = S3file.where(key: params[:key])
    end
    render 'search_result'
  end
    
  
  def search_result
  end
  
  private
  
    def get_s3_resource
      Aws::S3::Resource.new(region: @region)
    end
    
    def s3file_params
      params.require(:s3file).permit(:key, :image, :category, :channel_id)
    end
    
    def category_id_params
      params.require(:category_id)
    end
end
