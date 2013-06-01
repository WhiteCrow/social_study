class MicroblogsController < ApplicationController

  before_filter :require_user, except: [:show, :index]
  layout 'main', except: [:index]

  def index
    @microblogs = Microblog.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @microblogs }
    end
  end

  def show
    @microblog = Microblog.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @microblog }
    end
  end

  def new
    @microblog = Microblog.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @microblog }
    end
  end

  # GET /microblogs/1/edit
  def edit
    @microblog = Microblog.find(params[:id])
  end

  # POST /microblogs
  # POST /microblogs.json
  def create
    @microblog = Microblog.new(params[:microblog])
    @microblog.user = current_user

    respond_to do |format|
      if @microblog.save
        format.html { redirect_to root_path, notice: 'Microblog was successfully created.' }
        format.json { render json: @microblog, status: :created, location: @microblog }
      else
        format.html { render action: "new" }
        format.json { render json: @microblog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /microblogs/1
  # PUT /microblogs/1.json
  def update
    @microblog = Microblog.find(params[:id])

    respond_to do |format|
      if @microblog.update_attributes(params[:microblog])
        format.html { redirect_to @microblog, notice: 'Microblog was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @microblog.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @microblog = Microblog.find(params[:id])
    @microblog.destroy

    respond_to do |format|
      format.js
    end
  end
end
