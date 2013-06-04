class RelayMicroblog < Microblog
  belongs_to :origin,
             class_name: 'OriginMicroblog',
             dependent: :destroy,
             inverse_of: :origin

  attr_accessible :origin_id

  validates_uniqueness_of :user_id, scope: :origin_id
  validates_presence_of :origin_id, :user_id
  #validates_exclusion_of :user_id, in: []
  #TODO user_id couldn't eq self.origin.user_id

  delegate :content, to: :origin
  delegate :relay_microblogs, to: :origin

  def relay_by?(user)
    self.origin.relay_by?(user)
  end

end
