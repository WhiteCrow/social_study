class Audit
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  belongs_to :auditable, :polymorphic => true
  belongs_to :user
  attr_accessible :auditable, :auditable_id, :auditable_type, :act, :user, :user_id

  validates_inclusion_of :act, :in => ["update", "create", "destroy"]
  validates_presence_of :auditable, :act, :user

  field :act, type: String
  index :user_id => 1
  index :auditable_id => 1

end
