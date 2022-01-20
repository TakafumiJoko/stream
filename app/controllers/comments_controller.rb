class CommentsController < ApplicationController
  def create
    @video = Video.find(params[:video_id])
    @comment = @video.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    redirect_to video_path(@video)
  end

  def update
    
  end

  def destroy
    current_user.comments.find_by(id: params[:id], video_id: params[:video_id]).destroy
    @video = Video.find(params[:video_id])  
    redirect_to video_path(@video)
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:comment)
  end
  
end
