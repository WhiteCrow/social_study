FactoryGirl.define do
  factory :knowledge do
    sequence(:title){|n| n }
    sequence(:description){|n| "description #{n}" }
  end
end
