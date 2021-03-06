class Review
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Post

  has_many :reputations, as: :reputable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :user
  belongs_to :resource

  attr_accessible :user_id, :resource_id, :title, :content

  validates_presence_of :user_id, :resource_id, :title, :content
  alias_method :itemable, :resource

  index :user_id => 1
  index :resource_id => 1

  field :title, type: String
  field :content, type: String
  field :reputations_count, type: Integer, default: 0

  scope :top, ->(num=nil){ desc(:reputations_count).limit(num) }

  def repute_count(type)
    self.reputations.where(type: type).count
  end

end
