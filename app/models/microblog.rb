class Microblog
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Post

  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :user

  attr_accessible :user_id, :user
  validates_presence_of :user_id, :content

  index :user_id => 1

  scope :no_origin_user, ->(user){ not_in(origin_id: user.origin_microblog_ids) }
  # not display the following relay microblog if it write by user himself

end
