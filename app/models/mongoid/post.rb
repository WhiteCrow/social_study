module Mongoid
  module Post
    extend ActiveSupport::Concern

    def last_page_with_per_page(per_page)
      (self.comments.count.to_f / per_page).ceil
    end
  end
end
