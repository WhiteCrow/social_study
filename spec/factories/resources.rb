# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :resource do
    sequence(:title){|n| "resource title #{n}" }
    sequence(:description){|n| "resource description #{n}" }
    publish true
  end
end
