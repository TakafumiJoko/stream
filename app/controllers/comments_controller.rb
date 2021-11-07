class CommentsController < ApplicationController
  def create
    @video = Video.find(params[:video_id])
    @comment = @video.comments.build(comment_params)
    @comment.user = current_user
    @comment.save
    flash[:success] = "コメントに成功しました。"
    redirect_to @comment.video
  end

  def update
  end

  def destroy
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:comment)
  end
  
end
