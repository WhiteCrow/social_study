class Audit
  include Mongoid::History::Tracker
  delegate :comments, to: :auditable

  StateScope = ["microblog", "relay"]
  scope :states, where(action: 'create').in(scope: StateScope)

  def user
    if (user_id = self.modified["user_id"])
      User.find(user_id)
    elsif
      self.modifier
    end
  end

  def auditable
    obj_class = self.association_chain.first["name"].constantize
    obj_id = self.association_chain.first["id"]
    obj_class.find(obj_id)
  end

  def statable
    (self.auditable.is_a? Relay) ? self.auditable.relayable : self.auditable
  end

end
