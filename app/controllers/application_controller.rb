class ApplicationController < ActionController::Base
  #after_filter :store_location
  Time.send :include, TimeExt

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  def after_sign_up_path_for(user)
    request.referrer
  end

  def after_sign_out_path_for(user)
    request.referrer
  end

  def require_user
    if current_user.blank?
      respond_to do |format|
        format.html  {
          authenticate_user!
        }
        format.all {
          head(:unauthorized)
        }
      end
    end
  end


  def choose_layout
    action = params[:action]
    if ["edit", "new"].include? action
      'main'
    elsif ["index", "show", "top", "top_notes", "top_experiences", "top_reviews"].include? action
      'sidebar'
    end
  end

  def choose_post_layout
    if "index" == params[:action]
      'sidebar'
    else
      'main'
    end
  end

end
