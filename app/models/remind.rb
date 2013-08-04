module Remind
  extend ActiveSupport::Concern
  included do
    RemindScope = ["comment"]
    field :unread, type: Boolean, default: true
    scope :remind, where(action: 'create').in(scope: RemindScope)
  end
end
