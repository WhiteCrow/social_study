# coding: utf-8
module CommentsHelper
  def comments_link(commentable)
    link_to("#{commentable.comments.count}回复",
            commentable,
            remote: true,
            class: 'gray-link comment-link')
  end

  def state_comments_link(commentable)
    link_to("#{commentable.comments.count}回复",
            state_path(commentable),
            remote: true,
            class: 'gray-link comment-link')
  end
end
