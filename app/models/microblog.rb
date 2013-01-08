class Microblog
  include Mongoid::Document

  belongs_to :user
  attr_accessible :content
  validates_presence_of :content

  field :content, type: String
  index :user_id => 1
end
