class SearchController < ApplicationController
  def index
    redirect_to "https://www.google.com.hk/#hl=zh-CN&q=site:#{request.base_url}+#{params[:q]}"
  end
end
