class VideosController < ApplicationController
  
  skip_before_action :check_logged_in, only: [:home]

  def new
    @video = Video.new()
    @categories = Video.categories.to_a
    @channels = current_user.channels
  end
  
  def create
    
    file = video_params[:title]
    filename = file.original_filename
    file_path = "tmp/#{filename}"
    File.binwrite(file_path, file.read)
    
    Video.create(title: filename, category: video_params[:category], channel_id: video_params[:channel_id])
    @video = Video.last

    bucket = @s3.bucket(@bucketname)
    object = bucket.object("assets#{@video.id.to_s}/#{filename}")
    object.upload_file(file_path, acl: 'public-read')
    
    file = video_params[:thumbnail]
    filename = file.original_filename
    file_path = "tmp/#{filename}"
    File.binwrite(file_path, file.read)
    
    @video.update_attribute(:thumbnail, filename)
    
    object = bucket.object("assets#{@video.id.to_s}/#{filename}")
    object.upload_file(file_path, acl: 'public-read')
    
    redirect_to @video
  end
  
  def index
    
  end

  def show
    @video = Video.find(params[:id])
    @comment = Comment.new
    @video.histories.create(user_id: current_user.id)
    View.count(@video)
    OneDayView.count(@video)
    GoodOrBad.count(@video)
  end
  
  def initialize
    super
    @region = 'ap-northeast-1'
    @bucketname = 'bucket-for-stream'
    @s3 = get_s3_resource
  end
  
  def home
    @videos = Video.all
    @trend = Video.joins(:one_day_view).order(count: :desc).limit(10)
  end
  
  def music
    @videos = Video.where(category: "music")
  end
  
  def movie
    @videos = Video.where(category: "movie")
  end
  
  def program
    @videos = Video.where(category: "program")
  end
  
  def game
    @videos = Video.where(category: "game")
  end
  
  def news
    @videos = Video.where(category: "news")
  end
  
  def sports
    @videos = Video.where(category: "sports")
  end
  
  def learning
    @videos = Video.where(category: "learning")
  end
  
  def search
    if params[:title]
      @videos = Video.where(title: params[:title])
    else params[:category]
      @videos = Video.where(title: params[:title])
    end
    render 'search_result'
  end
    
  
  def search_result
  end

  def change_good_or_bad
    video = Video.find_by(id: params[:id])
    if good_or_bad = GoodOrBad.find_by(user_id: current_user.id, video_id: video.id)
      if good_or_bad.evaluation_type == good_or_bad_params[:evaluation_type].to_i
        good_or_bad.destroy
      else
        good_or_bad.update(evaluation_type: good_or_bad_params[:evaluation_type])
      end
    else
      GoodOrBad.create(user_id: current_user.id, video_id: video.id, evaluation_type: good_or_bad_params[:evaluation_type])
    end
    redirect_to video
  end

  private
  
    def get_s3_resource
      Aws::S3::Resource.new(region: @region)
    end
    
    def video_params
      params.require(:video).permit(:title, :thumbnail, :category, :channel_id)
    end
    
    def category_id_params
      params.require(:category_id)
    end
    
    def good_or_bad_params
      params.require(:good_or_bad).permit(:evaluation_type)
    end
end
