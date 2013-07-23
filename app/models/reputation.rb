# coding: utf-8
class Reputation
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::CounterCache

  belongs_to :user
  belongs_to :reputable, polymorphic: true, inverse_of: :reputable

  field :type, type: String
  field :user_id, type: String

  counter_cache :name => :reputable, :inverse_of => :reputations

  VoteTypes = %w(useful useless)
  scope :useful, where(type: 'useful')
  scope :useless, where(type: 'useless')

  validates_inclusion_of :type, in: VoteTypes,
                                if: Proc.new{|r| ["Note", "Experience", "Review"].include? r.reputable_type}
  validates_presence_of :type, :user_id
  validates_uniqueness_of :type, scope: [:user_id, :reputable]
  #TODO add custom validation that is user can't vote same reputalbe both useful and useless
end
