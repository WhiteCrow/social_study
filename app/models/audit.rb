class Audit
  include Mongoid::History::Tracker
  include State
  include Remind

  before_create :set_modifier

  def user
    if (user_id = self.modified["user_id"])
      User.find(user_id)
    elsif
      self.modifier
    end
  end

  def set_modifier
    self.modifier_id = self.modified["user_id"] if self.modifier_id.nil?
  end

  def auditable
    obj_class = self.association_chain.first["name"].constantize
    obj_id = self.association_chain.first["id"]
    obj_class.find(obj_id)
  end
end
