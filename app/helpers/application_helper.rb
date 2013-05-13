module ApplicationHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def follow_btn
    link_to('follow', follow_user_path(@user), remote: true, class: 'btn btn-primary')
  end

  def unfollow_btn
    link_to('unfollow', unfollow_user_path(@user), remote: true, class: 'btn btn-danger')
  end

  def operable(item)
    item.user == current_user and current_user.present?
  end

end
