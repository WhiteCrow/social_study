class Note
  include Mongoid::Document

  belongs_to :user
  belongs_to :knowledge

  index :user_id => 1
  index :knowledge_id => 1

  field :title, type: String
  field :content, type: String

end
