class ResourcesController < ApplicationController

  load_and_authorize_resource
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
    flash.now[:notice] = "你每天仅有30次创建知识或学习资源的机会，并且在审核通过前仅自己可见，今天还剩#{30 - current_user.created_nodes_count_today}次"
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

end
