class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to '/', :alert => exception.message
  end

  def after_sign_in_path_for(resource)
    redirect_to '/'
  end

  def after_sign_out_path_for(resource)
    redirect_to '/'
  end

  def redirect_back
    begin
      redirect_to :back
    rescue
      redirect_to '/'
    end
  end
end
