class NotesController < ApplicationController

  before_filter :require_user, except: [:show, :index]
  layout 'main', except: [:index]

  def index
    @notes = Note.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @notes }
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
      format.html { redirect_to notes_url }
    end
  end

end
