class CommentsController < ApplicationController

  def create
    commentable = params[:comment][:commentable_type].constantize.find(params[:comment][:commentable_id])
    last_page = commentable.last_page_with_per_page(20)
    @comment = commentable.comments.build(params[:comment])
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to controller: params[:comment][:commentable_type].tableize,
                                  action: 'show',
                                  id: params[:comment][:commentable_id],
                                  page: last_page}
        format.js{ render locals: {commentable: commentable} }
      else
        format.html { redirect_to commentable, notice: 'Comment create fail.' }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to request.referrer }
      format.js
    end
  end

  def paginate
    @commentable = params[:commentable_type].constantize.find(params[:commentable_id])
    @comments = @commentable.comments.page(params[:page]||1).per(20)

    respond_to do |format|
      format.js
    end
  end

end
