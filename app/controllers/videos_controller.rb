class VideosController < ApplicationController
  
  skip_before_action :check_logged_in, only: [:home]

  VIDEO_SHOWABLE_MAX_COUNT = 20

  def new
    @video = Video.new()
    @categories = Video.categories.to_a
    @channels = current_user.channels
  end
  
  def create
    files = [video_params[:title], video_params[:thumbnail]]
    create_localfile(files)
    @video = create_video
    tag_list = video_params[:tag_name].split(nil)
    @video.save_tag(tag_list)
    upload_s3file(files, @video)
    redirect_to @video
  end
  
  def index
    
  end

  def show
    @video = Video.find(params[:id])
    @comment = Comment.new
    @related_videos = []
    reccomend(@related_videos)
    @video.histories.create(user_id: current_user.id)
    View.count(@video)
    OneDayView.count(@video)
    GoodOrBad.count(@video)
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
  
    def initialize
      super
      @region = 'ap-northeast-1'
      @bucketname = 'bucket-for-stream'
      @s3 = get_s3_resource
    end
    
    def get_s3_resource
      Aws::S3::Resource.new(region: @region)
    end
    
    def get_filename(file)
      file.original_filename
    end
    
    def get_filepath(filename)
      "tmp/#{filename}"
    end
    
    def create_localfile(files)
      files.each do |file|
        filename = get_filename(file)
        filepath = get_filepath(filename)
        File.binwrite(filepath, file.read)
      end
    end
    
    def create_video
      Video.create(title: get_filename(video_params[:title]), 
                   thumbnail: get_filename(video_params[:thumbnail]), 
                   category: video_params[:category], 
                   channel_id: video_params[:channel_id])
    end
    
    def upload_s3file(files, video)
      bucket = @s3.bucket(@bucketname)
      files.each do |file|
        filename = get_filename(file)
        filepath = get_filepath(filename)
        object = bucket.object("assets#{video.id}/#{filename}")
        object.upload_file(filepath, acl: 'public-read')  
      end     
    end
    
    def reccomend(related_videos)
      @video.tags.each do |tag|
        if tag.videos.count < VIDEO_SHOWABLE_MAX_COUNT
          tag.videos.each_with_index do |video, num|
            if num == 5
              break
            end
            unless video.id == @video.id || related_videos.include?(video)
              related_videos.push(Video.find_by(id: video.id))
            end
          end
        end
      end
    end
    
    def video_params
      params.require(:video).permit(:title, :thumbnail, :category, :tag_name, :channel_id)
    end
    
    def category_id_params
      params.require(:category_id)
    end
    
    def good_or_bad_params
      params.require(:good_or_bad).permit(:evaluation_type)
    end
end
