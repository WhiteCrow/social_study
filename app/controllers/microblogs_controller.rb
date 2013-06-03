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
      format.js
    end
  end

  def new
    @microblog = Microblog.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @microblog }
    end
  end

  def edit
    @microblog = Microblog.find(params[:id])
  end

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

  def relay
    @microblog = Microblog.find(params[:id])
    if @microblog.relay_by?(current_user)
      @microblog.relayer_ids.delete(current_user.id)
    else
      @microblog.relayer_ids.push(current_user.id)
    end
    respond_to do |format|
      format.html{ render action: :show }
      format.js
    end
  end

end
