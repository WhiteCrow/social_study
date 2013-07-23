class Resource
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :reviews
  has_many :experiences, as: :experienceable

  validates_presence_of :title, :description
  validates_uniqueness_of :title

  field :title, type: String
  field :url, type: String
  field :description, type: String
  field :publish, :type => Boolean, :default => false

  def image
    'default-rel.png'
  end

end
