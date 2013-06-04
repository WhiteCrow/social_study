class HomeController < ApplicationController
  def index
    if current_user
      @microblog = OriginMicroblog.new
      @microblogs = Microblog.
                      in(user_id: [current_user.id] + current_user.following_ids).
                      no_origin_user(current_user).
                      desc('created_at').
                      page(params[:page]||1).per(20)
      respond_to do |format|
        format.html
        format.js { render 'microblogs/paginate' }
      end
    end
  end
end
