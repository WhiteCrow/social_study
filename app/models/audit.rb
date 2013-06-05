class Audit
  include Mongoid::History::Tracker

  StateScope = ["microblog", "relay"]
  scope :states, where(action: 'create').in(scope: StateScope)

  def auditable_user
    if (user_id = self.modified["user_id"])
      User.find(user_id)
    elsif
      self.modifier
    end
  end

end
