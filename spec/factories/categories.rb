require 'faker'
FactoryGirl.define do
  factory :category do
    name {Faker::Lorem.sentence}
    description {Faker::Lorem.paragraph}

    factory :invalid_factory do
      name nil
    end
  end
end
