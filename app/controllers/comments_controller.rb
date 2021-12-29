class CommentsController < ApplicationController
  def create
    @video = Video.find(params[:video_id])
    @comment = @video.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash.now[:notice] = 'コメントを投稿しました'
      render :video_comments 
    else
      render :error
    end    
  end

  def update
    
  end

  def destroy
    current_user.comments.find_by(id: params[:id], video_id: params[:video_id]).destroy
    flash.now[:alert] = '投稿を削除しました'
    @video = video.find(params[:video_id])  
    render :video_comments  
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:comment)
  end
  
end
