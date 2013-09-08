class CommentsController < ApplicationController

  def create
    commentable = params[:comment][:commentable_type].constantize.find(params[:comment][:commentable_id])
    if params[:comment][:auditable_type]
      auditable = params[:comment][:auditable_type].constantize.find(params[:comment][:auditable_id])
    end
    last_page = commentable.last_page_with_per_page(20)
    @comment = commentable.comments.build(params[:comment])
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to url_for(commentable) + '#footer', page: last_page}
        #used to states comments that in home page
        format.js{ render locals: {auditable: auditable} }
      else
        flash[:error] = '评论失败'
        format.html { redirect_to url_for(commentable) + '#footer' }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to request.referrer || root_path }
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
