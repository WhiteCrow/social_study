module Mongoid
  module ClearHistoryTracks
    extend ActiveSupport::Concern
    included do
      after_destroy :clear_history_tracks
    end

    def clear_history_tracks
      self.history_tracks.destroy_all
    end
  end
end
