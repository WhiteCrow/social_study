class ResourcesController < ApplicationController

  before_filter :require_user, except: [:show, :index]
  layout :choose_layout

  def index
    @newest_resources = Resource.hottest
    @hottest_resources = Resource.newest
    @reviews = Review.top(4)
    @experiences = Experience.where(experienceable_type: 'Resource').top(4)
  end

  def top
    @nodes = Resource.hottest(40).page(params[:page]).per(10)
    @title = '更多资源'
    respond_to do |format|
      format.html {render 'common/_nodes'}
    end
  end

  def top_experiences
    experiences = Experience.resource.top(36).page(params[:page]||1).per(9)
    @items = experiences
    @title = '更多心得'
    respond_to do |format|
      format.html {render 'common/_leaves'}
    end
  end

  def top_reviews
    reviews = Review.top(36).page(params[:page]||1).per(9)
    @items = reviews
    @title = '更多评论'
    respond_to do |format|
      format.html {render 'common/_leaves'}
    end
  end

  def show
    @resource = Resource.find(params[:id])
    @reviews = @resource.reviews.top(4)
    @grade_state = current_user.reputation_with(@resource).try(:type)
    @experiences = @resource.experiences.top(4)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @resource }
    end
  end

  # GET /resources/new
  # GET /resources/new.json
  def new
    @resource = Resource.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @resource }
    end
  end

  # GET /resources/1/edit
  def edit
    @resource = Resource.find(params[:id])
  end

  # POST /resources
  # POST /resources.json
  def create
    @resource = Resource.new(params[:resource])

    respond_to do |format|
      if @resource.save
        format.html { redirect_to @resource, notice: 'Resource was successfully created.' }
        format.json { render json: @resource, status: :created, location: @resource }
      else
        format.html { render action: "new" }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /resources/1
  # PUT /resources/1.json
  def update
    @resource = Resource.find(params[:id])

    respond_to do |format|
      if @resource.update_attributes(params[:resource])
        format.html { redirect_to @resource, notice: 'Resource was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /resources/1
  # DELETE /resources/1.json
  def destroy
    @resource = Resource.find(params[:id])
    @resource.destroy

    respond_to do |format|
      format.html { redirect_to resources_url }
      format.json { head :no_content }
    end
  end
end
