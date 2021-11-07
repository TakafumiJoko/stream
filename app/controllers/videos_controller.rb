class VideosController < ApplicationController

  skip_before_action :check_logged_in, only: :index
  
  def index
    @videos = Video.all
  end
  
  def new
    @video = Video.new
    @my_channels = current_user.channels
  end

  def create
    @video = current_user.videos.build(video_params)
    @video.save
    redirect_to @video
  end

  def show
    @video = Video.find(params[:id])
    @comment = Comment.new
  end

  private

  def video_params
    params.require(:video).permit(:title, :introduction, :video, :channel_id)
  end
end