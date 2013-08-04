module Remind
  extend ActiveSupport::Concern
  included do
    belongs_to :receiver, class_name: 'User'
    after_create :set_receiver
    RemindScope = ["comment"]
    field :unread, type: Boolean, default: true
    scope :remind, where(action: 'create').in(scope: RemindScope).ne(receiver_id: nil)
  end

  def set_receiver
    if self.is_remind?
      receiver_id = self.commentable.user_id

      if self.modifier_id != receiver_id
        self.update_attributes(receiver_id: receiver_id)
      end
    end
  end

  def is_remind?
    RemindScope.include? self.scope
  end

  def commentable
    if (commentable_type = self.modified["commentable_type"]).present?
      commentable_type.constantize.find(modified["commentable_id"])
    end
  end

end
