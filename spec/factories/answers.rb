FactoryGirl.define do
  factory :answer do
    content Faker::Lorem.word
    correct [true, false].sample
    question
  end
end
