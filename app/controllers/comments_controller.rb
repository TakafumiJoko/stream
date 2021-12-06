class CommentsController < ApplicationController
  def create
    @s3file = S3file.find(params[:s3file_id])
    @comment = @s3file.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash.now[:notice] = 'コメントを投稿しました'
      render :s3file_comments 
    else
      render :error
    end    
  end

  def update
    
  end

  def destroy
    Comment.find_by(id: params[:id], s3file_id: params[:s3file_id]).destroy
    flash.now[:alert] = '投稿を削除しました'
    @s3file = s3file.find(params[:s3file_id])  
    render :s3file_comments  
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:comment)
  end
  
end
