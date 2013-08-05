FactoryGirl.define do
  factory :knowledge do
    sequence(:title){|n| "title #{n}" }
    sequence(:description){|n| "description #{n}" }
    publish true
  end
end
