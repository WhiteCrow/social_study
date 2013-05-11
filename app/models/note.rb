class Note
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :reputations, dependent: :destroy
  belongs_to :user
  belongs_to :knowledge

  attr_accessible :user_id, :knowledge_id, :title, :content

  validates_presence_of :user_id, :knowledge_id, :title, :content

  index :user_id => 1
  index :knowledge_id => 1

  field :title, type: String
  field :content, type: String

end
