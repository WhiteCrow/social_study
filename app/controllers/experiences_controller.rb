class ExperiencesController < ApplicationController

  load_and_authorize_resource
  before_filter :require_user, except: [:show, :index]
  before_filter :get_experienceable, only: [:new]
  layout :choose_post_layout

  def get_experienceable
    @experienceable = params[:experienceable_type].constantize.find(params[:experienceable_id])
  end

  def index
    @experiences = Experience.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    @experience = Experience.find(params[:id])
    @experienceable = @experience.experienceable
  end

  def new
    @experience = @experienceable.experiences.new(user_id: current_user.id)
  end

  def edit
    @experience = Experience.find(params[:id])
    @experienceable = @experience.experienceable
  end

  def create
    @experienceable = params[:experience][:experienceable_type].constantize.find(params[:experience][:experienceable_id])
    @experience = @experienceable.experiences.build(params[:experience])
    @experience.user = current_user

    respond_to do |format|
      if @experience.save
        format.html { redirect_to @experience, notice: 'experience was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @experience = Experience.find(params[:id])
    @experienceable = @experience.experienceable

    respond_to do |format|
      if @experience.update_attributes(params[:experience])
        format.html { redirect_to @experience, notice: 'experience was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @experience = Experience.find(params[:id])
    @experience.destroy

    respond_to do |format|
      format.html { redirect_to experiences_url }
    end
  end

end
