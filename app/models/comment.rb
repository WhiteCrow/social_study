class Comment
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :content

  belongs_to :commentable, :polymorphic => true
  belongs_to :user

  attr_accessible :commentable_type, :commentable_id, :content, :commentable, :user_id, :user
  validates_presence_of :content, :commentable_type, :commentable_id, :user_id

  index :user_id => 1
  index :commentable_type => 1
  index :commentable_id => 1

end
