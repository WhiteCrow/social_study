class HomeController < ApplicationController
  def index
    if current_user
      @microblog = Microblog.new
      @microblogs = Microblog.in(user: current_user.following + [current_user]).desc('created_at').page(params[:page]||1).per(20)
      respond_to do |format|
        format.html
        format.js { render 'microblogs/paginate' }
      end
    end
  end
end
