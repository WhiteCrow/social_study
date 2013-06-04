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
    @microblog = Microblog.find(params[:id]).origin

    respond_to do |format|
      format.html # show.html.erb
      format.js
    end
  end

  def create
    @microblog = OriginMicroblog.new(params[:origin_microblog])
    @microblog.user = current_user

    respond_to do |format|
      if @microblog.save
        format.html { redirect_to root_path, notice: 'Microblog was successfully created.' }
        format.json { render json: @microblog, status: :created, location: @microblog }
      else
        format.html { redirect_to root_path }
        format.json { render json: @microblog.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @microblog = OriginMicroblog.find(params[:id])
    @microblog.destroy

    respond_to do |format|
      format.js
    end
  end

  def relay
    @microblog = OriginMicroblog.find(params[:id])
    if @microblog.relay_by?(current_user)
      @microblog.relay_microblogs.where(user_id: current_user.id).first.delete
    else
      relay_mb = @microblog.relay_microblogs.new(user_id: current_user.id)
      relay_mb.save!
    end
    respond_to do |format|
      format.html{ render action: :show }
      format.js
    end
  end

end
