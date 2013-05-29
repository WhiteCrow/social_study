class Microblog
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :user

  attr_accessible :content, :user_id, :user
  validates_presence_of :content, :user_id

  field :content, type: String
  index :user_id => 1

end
