class CommentsController < ApplicationController

  def create
    @comment = Comment.new(params[:comment])
    @comment.user = current_user
    binding.pry

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment.commentable, notice: 'Comment was successfully created.' }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to comments_url }
    end
  end
end
