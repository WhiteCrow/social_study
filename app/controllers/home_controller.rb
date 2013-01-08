class HomeController < ApplicationController
  def index
    @microblog = Microblog.new
  end
end
