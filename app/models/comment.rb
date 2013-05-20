class Comment
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :content

  belongs_to :commentable, :polymorphic => true
  belongs_to :user

  attr_accessible :commentable_type, :commentable_id, :content
  validates_presence_of :commentable, :content, :user

  index :user_id => 1
  index :commentable_type => 1
  index :commentable_id => 1

end
