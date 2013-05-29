class HomeController < ApplicationController
  def index
    @microblog = Microblog.new
    if current_user
      @microblogs = Microblog.in(user: current_user.following + [current_user]).desc('created_at')
    end
  end
end
