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
    link_to('follow', follow_user_path(@user), remote: true, method: :post, class: 'btn btn-primary')
  end

  def unfollow_btn
    link_to('unfollow', unfollow_user_path(@user), remote: true, method: :post, class: 'btn btn-danger')
  end

  def operable(item)
    item.user == current_user and current_user.present?
  end

  def short_content(item)
    content = strip_tags(item.content)
    if content.length < 400
      content
    else
      content.first(400) + '......'
    end
  end

end
