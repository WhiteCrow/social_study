class CommentsController < ApplicationController

  def create
    commentable = params[:comment][:commentable_type].constantize.find(params[:comment][:commentable_id])
    @comment = commentable.comments.build(params[:comment])
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment.commentable, notice: 'Comment was successfully created.' }
      else
        format.html { redirect_to @comment.commentable, notice: 'Comment create fail.' }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    commentable = @comment.commentable
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to commentable }
    end
  end

end
