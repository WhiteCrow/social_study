class ReviewsController < ApplicationController

  before_filter :require_user, except: [:show, :index]
  layout :choose_post_layout

  def index
    @reviews = Review.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    @review = Review.find(params[:id])
    @resource = @review.resource
  end

  def new
    @review = current_user.reviews.build(resource_id: params[:resource_id])
    @resource = Resource.find(params[:resource_id])
  end

  def edit
    @review = Review.find(params[:id])
    @resource = @review.resource
  end

  def create
    @review = current_user.reviews.build(params[:review])

    respond_to do |format|
      if @review.save
        format.html { redirect_to @review, notice: 'review was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @review = Review.find(params[:id])

    respond_to do |format|
      if @review.update_attributes(params[:review])
        format.html { redirect_to @review, notice: 'review was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy

    respond_to do |format|
      format.html { redirect_to @review.resource }
    end
  end
end
