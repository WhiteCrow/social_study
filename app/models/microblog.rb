class Microblog
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Post
  include Mongoid::History::Trackable
  include Mongoid::ClearHistoryTracks

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :relays, as: :relayable, dependent: :destroy
  belongs_to :user

  after_destroy :destroy_relays

  attr_accessible :user_id, :user, :content
  validates_presence_of :user_id, :content
  validates_length_of :content, maximum: 140

  def state
    self.history_tracks.first
  end

  def destroy_relays
    self.relays.destroy_all
  end

  track_history on: [:content, :user_id],
                track_create:  true,
                track_update:  false,
                track_destroy: false,
                :modifier_field => :modifier,
                :modifier_field_inverse_of => :user

  index :user_id => 1
  field :content, type: String

end
