FactoryGirl.define do
  factory :question do
    content Faker::Lorem.sentence

    before(:create) do |question|
      answers_attributes = []

      Settings.default_answers_num.times do |n|
        bool = n==0 ? true : false
        answers_attributes << attributes_for(:answer, correct: bool)
      end

      question.answers_attributes = answers_attributes
    end

    category
  end
end
