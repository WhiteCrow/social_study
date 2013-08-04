class Comment
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::History::Trackable
  include Mongoid::ClearHistoryTracks

  field :content

  belongs_to :commentable, :polymorphic => true
  belongs_to :user

  validates_presence_of :content, :commentable_type, :commentable_id, :user_id

  default_scope asc('created_at')

  index :user_id => 1
  index :commentable_type => 1
  index :commentable_id => 1

  track_history on: [:content, :user_id],
                track_create:  true,
                track_update:  false,
                track_destroy: false,
                :modifier_field => :modifier,
                :modifier_field_inverse_of => :user

  index :user_id => 1
  field :content, type: String

end
