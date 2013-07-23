FactoryGirl.define do
  factory :experience do
    sequence(:title){|n| "title #{n}" }
    content "MyText"
    association :user
    association :experienceable, factory: :knowledge
  end
end
