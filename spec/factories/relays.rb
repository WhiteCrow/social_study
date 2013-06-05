FactoryGirl.define do
  factory :relay do
    association :user
    association :relayable
  end
end
