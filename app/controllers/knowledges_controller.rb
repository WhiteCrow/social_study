class KnowledgesController < ApplicationController

  layout :choose_layout

  def choose_layout
    action = params[:action]
    if ["edit", "new"].include? action
      return 'main'
    elsif ["index", "show", "notes"].include? action
      return 'sidebar'
    end
  end

  def index
    @newest_knowledges = Knowledge.order_by(created_at: :desc)
    @hottest_knowledges = Knowledge.order_by(created_at: :desc)
    @notes = Note.top(4)
    @experiences = Experience.top(4)
  end

  def notes
    @knowledge = Knowledge.find(params[:knowledge_id])
    @notes = @knowledge.notes.top
  end

  def experiences
    @knowledge = Knowledge.find(params[:knowledge_id])
    @experiences = @knowledge.experiences.top
  end


  def show
    @knowledge = Knowledge.find(params[:id])
    @notes = @knowledge.notes.top(4)
    @experiences = Experience.top(4)
  end

  def new
    @knowledge = Knowledge.new
  end

  def edit
    @knowledge = Knowledge.find(params[:id])
  end

  def create
    @knowledge = Knowledge.new(params[:knowledge])

    respond_to do |format|
      if @knowledge.save
        format.html { redirect_to @knowledge, notice: 'Knowledge was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @knowledge = Knowledge.find(params[:id])

    respond_to do |format|
      if @knowledge.update_attributes(params[:knowledge])
        format.html { redirect_to @knowledge, notice: 'Knowledge was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

end
