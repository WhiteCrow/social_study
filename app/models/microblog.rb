class Microblog
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Post
  include Mongoid::Relayable

  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :user

  attr_accessible :content, :user_id, :user
  validates_presence_of :content, :user_id
  validates_length_of :content, maximum: 140

  field :content, type: String
  index :user_id => 1

end
