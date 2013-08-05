class HomeController < ApplicationController
  def index
    if current_user
      @microblog = Microblog.new
      @states = Audit.state.
                      in(:modifier => [current_user] + current_user.following).
                      desc('created_at').
                      page(params[:page]||1).per(20)
      respond_to do |format|
        format.html
        format.js { render 'states/paginate' }
      end
    end
  end
end
