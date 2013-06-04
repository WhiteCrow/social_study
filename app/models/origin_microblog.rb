class OriginMicroblog < Microblog
  has_many :relay_microblogs, as: 'origin'
  field :content, type: String

  attr_accessible :content

  validates_length_of :content, maximum: 140
  validates_presence_of :content

  def relay_by?(user)
    self.relay_microblogs.each do |rm|
     return true if rm.user_id == user.id
    end
    return false
  end

  def origin
    self
  end

end
