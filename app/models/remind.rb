module Remind
  extend ActiveSupport::Concern
  included do
    RemindScope = ["comment"]
    belongs_to :receiver, class_name: 'User'
    before_create :set_receiver
    scope :remind, where(action: 'create').in(scope: RemindScope).ne(receiver_id: nil)
    validates_presence_of :unread
    #TODO will add the validation
    #validates_presence_of :receiver_id,
    #                      if: Proc.new{|r| r.remind?},
    #                      on: :create

    field :unread, type: Boolean, default: true
  end

  def set_receiver
    if self.is_remind?
      self.receiver_id = self.commentable.user_id
    end
  end

  def is_remind?
    RemindScope.include?(self.scope) and modifier_id != self.commentable.user_id
  end

  def commentable
    if (commentable_type = self.modified["commentable_type"]).present?
      commentable_type.constantize.find(modified["commentable_id"])
    end
  end

end
