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
    current_user.present? and (
      item == current_user or
      (item.respond_to?(:user) and item.user == current_user) or
      (item.respond_to?(:modifier) and item.modifier== current_user)
    )
  end

  def short_content(item)
    content = strip_tags(item.content)
    if content.length < 400
      content
    else
      content.first(400) + '......'
    end
  end

  def unread_remind_count
    current_user.unread_reminds.count
  end

  def remind_count_bgcolor
    unread_remind_count > 0 ? "background-color:#bd362f;" : "background-color:#ccc;"
  end

end
