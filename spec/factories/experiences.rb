FactoryGirl.define do
  factory :experience do
    sequence(:title){|n| "title #{n}" }
    content "MyText"
    association :user
    association :knowledge
  end
end
