class Reference
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :url_add, type: String
  field :description, type: String

  field :publish, :type => Boolean, :default => false

  validates_presence_of :title, :description
  validates_uniqueness_of :title
  validates :url_add, :format => { :with => /^http:/i, :on => :create }

end
