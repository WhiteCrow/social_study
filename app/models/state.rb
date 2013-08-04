module State
  extend ActiveSupport::Concern
  included do
    StateScope = ["microblog", "relay"]
    delegate :comments, to: :auditable
    scope :state, where(action: 'create').in(scope: StateScope)
  end

  def statable
    (self.auditable.is_a? Relay) ? self.auditable.relayable : self.auditable
  end

end
