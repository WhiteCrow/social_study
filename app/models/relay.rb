class Relay
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::History::Trackable
  include Mongoid::ClearHistoryTracks
  belongs_to :user
  belongs_to :relayable,
             polymorphic: true,
             inverse_of: :relayable

  index user_id: 1

  delegate :content, to: :relayable
  delegate :comments, to: :relayable

  validates_uniqueness_of :user_id, scope: [:relayable_id, :relayable_type]
  validates_presence_of :relayable_id, :user_id

  #TODO user_id couldn't eq self.relayable.user_id
  #validates_exclusion_of :user_id, in: []

  track_history on: [:relay, :user_id],
                track_create:  true,
                track_destroy: false,
                track_update: false,
                :modifier_field => :modifier,
                :modifier_field_inverse_of => :user

end
