class KnowledgesController < ApplicationController

  layout :choose_layout

  def index
    @newest_knowledges = Knowledge.newest
    @hottest_knowledges = Knowledge.hottest
    @notes = Note.top(4)
    @experiences = Experience.where(experienceable_type: 'Knowledge').top(4)
  end

  def top
    @knowledges = Knowledge.hottest(40).page(params[:page]||1).per(10)
    respond_to do |format|
      format.html
      format.js
    end
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
