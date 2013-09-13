class RemindsController < ApplicationController

  before_filter :require_user

  def index
    @reminds = Kaminari.paginate_array(current_user.all_reminds).
                page(params[:page]||1).per(20)
    respond_to do |format|
      format.html
      format.js { render 'paginate' }
    end
  end

  def short_index
    @reminds = current_user.all_reminds.first(5)
    @read_count = current_user.read_all_reminds
    respond_to do |format|
      format.html {render :index}
      format.js
    end
  end
end
