class ExperiencesController < ApplicationController

  before_filter :require_user, except: [:show, :index]
  layout 'main', except: [:index]

  def index
    @experiences = Experience.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    @experience = Experience.find(params[:id])
    @knowledge = @experience.knowledge
  end

  def new
    @experience = current_user.experiences.build(knowledge_id: params[:knowledge_id])
    @knowledge = Knowledge.find(params[:knowledge_id])
  end

  def edit
    @experience = Experience.find(params[:id])
    @knowledge = @experience.knowledge
  end

  def create
    @experience = current_user.experiences.build(params[:experience])

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

  def reputed
    @experience = Experience.find(params[:id])
    if reputation = current_user.reputations.select{|r| r.reputable == @experience }.first
      #delete duplicated or conflict reputation or exisit reputation
      @pre_reputed_type = reputation.type
      reputation.destroy
    end
    if params[:repute_type] != @pre_reputed_type
      @reputation = @experience.reputations.create!({user: current_user, type: params[:repute_type]})
    end
    respond_to do |format|
      format.js
    end
  end
end
