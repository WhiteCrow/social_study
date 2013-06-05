# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :microblog do
    content 'It is a microblog'
    association :user
  end
end
