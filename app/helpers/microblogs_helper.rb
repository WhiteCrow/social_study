# coding: utf-8
module MicroblogsHelper
  def relay_link(state)
    if current_user.relay? state.statable
      relayed_link(state)
    else
      unrelay_link(state)
    end
  end

  def unrelay_link(state)
    link_to '转播',
            relay_state_path(state),
            remote: true,
            method: :post,
            class: 'pl5 hide unrelay-link'
  end

  def relayed_link(state)
    link_to '已转播',
            relay_state_path(state),
            remote: true,
            method: :post,
            class: 'pl5 hide relayed-link'
  end

  def relayer_link(state)
    if (relayable = state.auditable).is_a? Relay
      link_to relayable.user.name, relayable.user, class: 'gray-link'
    end
  end
end
