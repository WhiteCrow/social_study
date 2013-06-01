# coding: utf-8
module CommentsHelper
  def remote_show_comments_link(commentable)
    link_to("#{commentable.comments.count}回复",
            commentable,
            remote: true,
            class: 'gray-link comment-link')
  end
end
