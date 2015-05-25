FactoryGirl.define do
  factory :user do
    name Faker::Name.name
    email Faker::Internet.email
    password 'password'
    password_confirmation {password}
  end

  factory :admin, class: User do
    name "Example User"
    email "example@railstutorial.org"
    password "12345678"
    password_confirmation {password}
    role "admin"
  end
end
