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

  CollectTypes = %w(collect)
  VoteTypes = %w(useful useless)
  StudyTypes = %w(想学 入门 熟练 精通 专家)
  GradeTypes = %w(1 2 3 4 5)

  [:useful, :useless, :collect].each do |type|
    scope type , where(type: type.to_s)
  end

  validates_inclusion_of :type, in: VoteTypes + CollectTypes,
                                if: Proc.new{|r| ["Note", "Experience", "Review"].include? r.reputable_type}
  validates_inclusion_of :type, in: StudyTypes,
                                if: Proc.new{|r| "Knowledge" ==  r.reputable_type}
  validates_inclusion_of :type, in: GradeTypes + ['collect'],
                                if: Proc.new{|r| "Resource" ==  r.reputable_type}
  validates_presence_of :type, :user_id, :reputable_type, :reputable_id
  validates_uniqueness_of :type, scope: [:user_id, :reputable]
  #TODO add custom validation that is user can't vote same reputalbe both useful and useless
end
