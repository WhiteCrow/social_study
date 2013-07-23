class Experience
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Post

  has_many :reputations, as: :reputable
  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :user
  belongs_to :experienceable, polymorphic: true, inverse_of: :experienceable

  attr_accessible :user_id, :experienceable, :title, :content

  validates_presence_of :user_id, :experienceable, :title, :content

  index :user_id => 1

  field :title, type: String
  field :content, type: String
  field :reputations_count, type: Integer, default: 0

  scope :top, ->(num=nil){ desc(:reputations_count).limit(num) }

  def repute_count(type)
    self.reputations.where(type: type).count
  end

  def short_content
    self.content.first(1000)
  end

end
