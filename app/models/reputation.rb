# coding: utf-8
class Reputation
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  belongs_to :user
  belongs_to :reputable, polymorphic: true

  field :type, type: String
  index user_id: 1
  index reputable_type: 1
  index reputable_id: 1

  VoteTypes = %w(useful useless)

  validates_inclusion_of :type, in: VoteTypes,
                                if: Proc.new{|r| ['Note', 'Experience', 'Review'].include? r.reputable_type}
  validates_presence_of :type, :user_id, :reputable_type, :reputable_id
  validates_uniqueness_of :reputable, scope: :user_id
end
