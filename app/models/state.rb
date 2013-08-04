module State
  extend ActiveSupport::Concern
  included do
    StateScope = ["microblog", "relay"]
    scope :state, where(action: 'create').in(scope: StateScope)
  end

  def statable
    (self.auditable.is_a? Relay) ? self.auditable.relayable : self.auditable
  end

end
