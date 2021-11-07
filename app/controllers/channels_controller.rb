class ChannelsController < ApplicationController
  def index
  end

  def new
    @channel = Channel.new
  end
  
  def create
    @channel = current_user.channels.build(channel_params)
    @channel.save
    flash[:success] = "チャンネル作成に成功しました。"
    redirect_to "/users/#{@channel.user_id}/channels/#{@channel.id}"
  end
  
  def show
    @channel = Channel.find(params[:id])
  end

  def edit
  end
  
  private
  
  def channel_params
    params.require(:channel).permit(:name)
  end
end
