# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :note do
    sequence(:title){|n| "title #{n}" }
    content "MyText"
    association :user
    association :knowledge
  end
end
