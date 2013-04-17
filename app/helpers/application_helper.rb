module ApplicationHelper
  def follow_btn
    link_to('follow him', follow_user_path(@user), remote: true, class: 'btn btn-primary')
  end
end
