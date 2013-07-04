class Resource
  include Mongoid::Document
  include Mongoid::Timestamps

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
