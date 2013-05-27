class NotesController < ApplicationController

  before_filter :require_user, except: [:show, :index]
  layout 'main', except: [:index]

  def index
    @notes = Note.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    @note = Note.find(params[:id])
    @knowledge = @note.knowledge
  end

  def new
    @note = current_user.notes.build(knowledge_id: params[:knowledge_id])
    @knowledge = Knowledge.find(params[:knowledge_id])
  end

  def edit
    @note = Note.find(params[:id])
    @knowledge = @note.knowledge
  end

  def create
    @note = current_user.notes.build(params[:note])

    respond_to do |format|
      if @note.save
        format.html { redirect_to @note, notice: 'Note was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @note = Note.find(params[:id])

    respond_to do |format|
      if @note.update_attributes(params[:note])
        format.html { redirect_to @note, notice: 'Note was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy

    respond_to do |format|
      format.html { redirect_to @note.knowledge }
    end
  end

  def reputed
    @note = Note.find(params[:id])
    if reputation = current_user.reputations.select{|r| r.reputable == @note }.first
      #delete duplicated or conflict reputation or exisit reputation
      @pre_reputed_type = reputation.type
      reputation.destroy
    end
    if params[:repute_type] != @pre_reputed_type
      @reputation = @note.reputations.create!({user: current_user, type: params[:repute_type]})
    end
    respond_to do |format|
      format.js
    end
  end
end
