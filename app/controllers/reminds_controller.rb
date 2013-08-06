class RemindsController < ApplicationController

  before_filter :require_user

  def index
    @reminds = current_user.reminds.page(params[:page]||1).per(20)
    respond_to do |format|
      format.html
      format.js { render 'paginate' }
    end
  end

  def short_index
    @reminds = current_user.reminds.limit(5)
    current_user.read_all_reminds
    respond_to do |format|
      format.html {render :index}
      format.js
    end
  end
end
