# config/initializers/mongoid-audit.rb
# initializer for mongoid-audit
# assuming HistoryTracker is your tracker class
Mongoid::Audit.tracker_class_name = :audit
Mongoid::Audit.current_user_method = :current_user
require_dependency 'audit.rb'
