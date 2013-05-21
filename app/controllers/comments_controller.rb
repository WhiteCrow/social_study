class CommentsController < ApplicationController

  def create
    @comment = current_user.comments.build(params[:comment])

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment.commentable, notice: 'Comment was successfully created.' }
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
