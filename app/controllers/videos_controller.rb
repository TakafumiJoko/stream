class VideosController < ApplicationController

  skip_before_action :check_logged_in, only: :new
  
  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)
    @video.save
    redirect_to @video
  end

  def show
    @video = Video.find(params[:id])
  end

  private

  def video_params
    params.require(:video).permit(:title, :introduction, :video)
  end
end