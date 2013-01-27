module Auditor
  module Mention
    extend ActiveSupport::Concern
    included do
      after_create do
        Audit.create!(:auditable => self, :act => "create")
      end
      after_update do
        Audit.create!(:auditable => self, :act => "create")
      end
    end
  end
end
