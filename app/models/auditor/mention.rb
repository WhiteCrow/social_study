module Auditor
  module Mention
    extend ActiveSupport::Concern
    included do
      after_create  do
#        create_audit({act: 'create'})
        Audit.create!(user: self.user, auditable: self , act: 'create')
      end
#      after_update do 
#        create_audit({act: 'update'})
#      end
    end

    def create_auidt(options={})
      puts 'test'
#      Audit.create!(user: self.user, auditable: self , act: options[:act])
    end
  end
end
