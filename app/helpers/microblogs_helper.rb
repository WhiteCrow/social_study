# coding: utf-8
module MicroblogsHelper
  def relay_link(microblog)
    om = microblog.origin
    if om.relay_by?(current_user)
      relayed_link(om)
    else
      unrelay_link(om)
    end
  end

  def unrelay_link(microblog)
    link_to '转播',
            relay_origin_microblog_path(microblog),
            remote: true,
            method: :post,
            class: 'pl5 hide unrelay-link'
  end

  def relayed_link(microblog)
    link_to '已转播',
            relay_origin_microblog_path(microblog),
            remote: true,
            method: :post,
            class: 'pl5 hide relayed-link'
  end

  def relayer_link(microblog)
    if microblog.is_a? RelayMicroblog
      link_to microblog.user.name, microblog.user
    end
  end
end
