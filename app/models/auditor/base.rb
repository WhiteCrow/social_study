class Auditor::Base
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  belongs_to :auditable, :polymorphic => true
  belongs_to :user
  attr_accessible :auditable_type, :auditable_id, :body

  validates_inclusion_of :act, :in => ["update", "create", "destroy"]
  validates_presence_of :auditable, :act

  field :act, type: String
  index :user_id => 1
  index :commentable_type => 1
  index :auditable_id => 1
end
