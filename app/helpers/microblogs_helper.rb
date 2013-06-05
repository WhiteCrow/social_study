# coding: utf-8
module MicroblogsHelper
  def relay_link(microblog)
    if microblog.relay_by?(current_user)
      relayed_link(microblog)
    else
      unrelay_link(microblog)
    end
  end

  def unrelay_link(microblog)
    link_to '转播',
            relay_microblog_path(microblog),
            remote: true,
            method: :post,
            class: 'pl5 hide unrelay-link'
  end

  def relayed_link(microblog)
    link_to '已转播',
            relay_microblog_path(microblog),
            remote: true,
            method: :post,
            class: 'pl5 hide relayed-link'
  end

  #def relayer_link(microblog)
  #  if microblog.is_a? RelayMicroblog
  #    link_to microblog.user.name, microblog.user
  #  end
  #end
end
