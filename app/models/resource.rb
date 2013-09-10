class Resource
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  has_many :reputations, as: :reputable, dependent: :destroy
  has_many :reviews
  has_many :experiences, as: :experienceable

  scope :hottest, ->(num=16){desc('created_at').limit(num)}
  scope :newest, ->(num=16){desc('created_at').limit(num)}

  validates_presence_of :title, :description, :user_id
  validates_uniqueness_of :title

  field :title, type: String
  field :url, type: String
  field :description, type: String
  field :publish, :type => Boolean, :default => false
  index :user_id => 1

  def image
    'default-rel.png'
  end

end
