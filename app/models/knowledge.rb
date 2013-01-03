class Knowledge
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :second_title, type: String
  field :description, type: String
  field :knowledge_association_id, type: Integer
  field :publish, :type => Boolean, :default => false

  validates_presence_of :title, :description
  validates_uniqueness_of :title


end
