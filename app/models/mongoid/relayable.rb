module Mongoid
  module Relayable
    extend ActiveSupport::Concern
    included do
      field :relayer_ids, type: Array, default: []
      field :relay_count, type: Integer, default: 0
    end

    def relay_by?(user)
      return false if user.blank?
      self.relayer_ids.include?(user.id)
    end
  end
end
