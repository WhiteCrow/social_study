class MicroblogsController < ApplicationController

  def show
    microblog = Microblog.find(params[:id])
    redirect_to state_path(microblog.state.id)
  end

  def create
    @microblog = Microblog.new(params[:microblog])
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
end
