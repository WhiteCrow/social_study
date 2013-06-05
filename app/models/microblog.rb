class Microblog
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Post
  include Mongoid::History::Trackable

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :relays, as: :relayable
  belongs_to :user

  attr_accessible :user_id, :user, :content
  validates_presence_of :user_id, :content
  validates_length_of :content, maximum: 140

  def relay_by?(user)
    self.relays.each do |relay|
     return true if relay.user_id == relay.id
    end
    return false
  end

  track_history on: [:content, :user_id],
                track_create:  true,
                track_destroy: true

  index :user_id => 1
  field :content, type: String

end
