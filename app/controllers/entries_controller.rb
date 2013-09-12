class EntriesController < ApplicationController
  include ActionView::Helpers::OutputSafetyHelper

  before_filter :require_user, except: [:show, :index, :next, :add_to_previous]

  def index
    @user = User.find(params[:user_id])
    @entries = @user.special_entry_by('default').to_a
    respond_to do |format|
      format.json { render json: @entries }
    end
  end

  def history
    user = User.find(params[:user_id])
    @entries_titles = user.entries.desc('created_at').pluck(:title)
    render partial: 'entries/history'
  end

  def next
    title = params[:title]
    @user = User.find(params[:user_id])
    begin
      @entry = @user.entries.find_by(title: title)
      respond_to do |format|
        format.json { render json: @entry }
      end
    rescue Mongoid::Errors::DocumentNotFound
      @entry = @user.entries.new(title: title)
      respond_to do |format|
        format.json { render json: @entry }
      end
    end
  end

  def show
    @entry = Entry.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def new
    @entry = Entry.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @entry }
    end
  end

  def edit
    begin
      @entry = Entry.find(params[:id])
    rescue Mongoid::Errors::DocumentNotFound
      @entry = current_user.entries.new(title: params[:title])
    end
    render partial: 'entries/form'
  end

  def cancel_edit
    @entry = Entry.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def create
    @entry = current_user.entries.new(params[:entry])
    respond_to do |format|
      if @entry.save
        format.json { render json: @entry, status: :created, location: @entry }
      else
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    begin
      @entry = Entry.find(params[:id])
    rescue Mongoid::Errors::DocumentNotFound
      return create
    end
    respond_to do |format|
      if @entry.update_attributes(params[:entry])
        format.json { render json: @entry }
      else
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @entry = Entry.find(params[:id])
    @entry.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end
end
