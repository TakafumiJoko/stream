class VideosController < ApplicationController

  skip_before_action :check_logged_in, only: :new
  
  def new
    @video = Video.new
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
    params.require(:video).permit(:title, :introduction, :video)
  end
end