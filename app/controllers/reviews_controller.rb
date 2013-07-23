class ReviewsController < ApplicationController

  before_filter :require_user, except: [:show, :index]
  layout :choose_layout

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

  def reputed
    @review = Review.find(params[:id])
    if reputation = current_user.reputations.select{|r| r.reputable == @review }.first
      #delete duplicated or conflict reputation or exisit reputation
      @pre_reputed_type = reputation.type
      reputation.destroy
    end
    if params[:repute_type] != @pre_reputed_type
      @reputation = @review.reputations.create!({user: current_user, type: params[:repute_type]})
    end
    respond_to do |format|
      format.js
    end
  end
end
