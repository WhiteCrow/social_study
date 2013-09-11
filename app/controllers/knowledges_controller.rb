class KnowledgesController < ApplicationController

  load_and_authorize_resource
  layout :choose_layout

  def index
    @newest_knowledges = Knowledge.newest
    @hottest_knowledges = Knowledge.hottest
    @notes = Note.top(4)
    @experiences = Experience.where(experienceable_type: 'Knowledge').top(4)
  end

  def top
    @nodes = Knowledge.hottest(40).page(params[:page]).per(10)
    @title = '更多知识'
    respond_to do |format|
      format.html {render 'common/_nodes'}
    end
  end

  def top_experiences
    experiences = Experience.knowledge.top(36).page(params[:page]||1).per(9)
    @items = experiences
    @title = '更多心得'
    respond_to do |format|
      format.html {render 'common/_leaves'}
    end
  end

  def top_notes
    notes = Note.top(36).page(params[:page]||1).per(9)
    @items = notes
    @title = '更多笔记'
    respond_to do |format|
      format.html {render 'common/_leaves'}
    end
  end

  def experiences
    @knowledge = Knowledge.find(params[:knowledge_id])
    @experiences = @knowledge.experiences.top
  end

  def show
    @knowledge = Knowledge.find(params[:id])
    @notes = @knowledge.notes.top(4)
    @experiences = @knowledge.experiences.top(4)
  end

  def new
    @knowledge = current_user.knowledges.new
    flash.now[:notice] = "你每天仅有30次创建知识或学习资源的机会，并且在审核通过前仅自己可见，今天还剩#{30 - current_user.created_nodes_count_today}次"
  end

  def edit
    @knowledge = Knowledge.find(params[:id])
  end

  def create
    @knowledge = current_user.knowledges.new(params[:knowledge])

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
