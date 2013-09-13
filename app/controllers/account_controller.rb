# coding: utf-8
class AccountController < Devise::RegistrationsController
  layout 'main', only: [:edit, :update]
  def edit
    @user = current_user
    # 首次生成用户 Token
    #@user.update_private_token if @user.private_token.blank?
  end

  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)

    # Can update Email when email was not has being exist.
    resource.email = resource_params[:email] if self.resource.email.blank?

    # code from Devise
    if resource.update_without_password(resource_params)
      if is_navigational_format?
        if resource.respond_to?(:pending_reconfirmation?) && resource.pending_reconfirmation?
          flash_key = :update_needs_confirmation
        end
        set_flash_message :notice, flash_key || :updated
      end
      sign_in resource_name, resource, :bypass => true
      flash[:notice] = "账户更新成功"
      #respond_with resource, :location => after_update_path_for(resource)
      redirect_to '/'
    else
      clean_up_passwords resource
      flash.now[:error] = "请输入正确的密码"
      respond_with resource
    end
  end

  # POST /resource
  def create
    build_resource
    resource.email = params[resource_name][:email]
    if resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_in(resource_name, resource)
        #respond_with resource, :location => after_sign_up_path_for(resource)
        redirect_to edit_user_registration_path
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  def destroy
    resource.soft_delete
    sign_out_and_redirect("/sign_in")
    set_flash_message :notice, :destroyed
  end
end
