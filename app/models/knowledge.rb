class Knowledge
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :reputations, as: :reputable, dependent: :destroy
  has_many :notes
  has_many :experiences, as: :experienceable

  validates_presence_of :title, :description
  validates_uniqueness_of :title

  scope :hottest, ->(num=16){desc('created_at').limit(num)}
  scope :newest, ->(num=16){desc('created_at').limit(num)}

  field :title, type: String
  field :second_title, type: String
  field :description, type: String
  #field :knowledge_association_id, type: String
  field :publish, :type => Boolean, :default => false

  def image
    'default-know.jpg'
  end
end
