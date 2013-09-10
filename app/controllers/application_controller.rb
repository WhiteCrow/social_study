class ApplicationController < ActionController::Base
  load_and_authorize_resource
  #after_filter :store_location
  Time.send :include, TimeExt

  rescue_from CanCan::AccessDenied do |exception|
    if request.env["HTTP_REFERER"]
      redirect_to :back, :alert => '你没有权限进行这个操作'
    else
      redirect_to '/', :alert => '你没有权限进行这个操作'
    end
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
