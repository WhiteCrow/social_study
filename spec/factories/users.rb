FactoryGirl.define do
  factory :user do
    sequence(:name){|n| "name#{n}" }
    sequence(:email){|n| "email#{n}@example.com" }
    role 'user'
    password 'password'
    password_confirmation 'password'
  end

  factory :admin, parent: :user do
    role 'admin'
  end

end
