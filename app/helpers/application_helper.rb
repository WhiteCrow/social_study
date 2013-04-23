module ApplicationHelper
  def follow_btn
    link_to('follow', follow_user_path(@user), remote: true, class: 'btn btn-primary')
  end

  def unfollow_btn
    link_to('unfollow', unfollow_user_path(@user), remote: true, class: 'btn btn-danger')
  end

end
