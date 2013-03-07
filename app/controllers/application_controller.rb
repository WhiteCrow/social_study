class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

#  def after_sign_in_path_for(user)
#    redirect_to root_path
#  end

  def after_sign_out_path_for(user)
    request.referrer
  end
end
