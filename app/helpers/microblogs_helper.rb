# coding: utf-8
module MicroblogsHelper
  def microblog_comments_link(microblog)
    link_to("#{microblog.comments.count}回复",
            comment_microblog_path(microblog),
            remote: true,
            class: 'gray-link coment-link')
  end
end
