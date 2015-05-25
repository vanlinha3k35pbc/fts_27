require 'rails_helper'

describe Question do
  it {is_expected.to be_a_new Question}
  it {expect(create :question).to be_valid} 
  it {is_expected.to belong_to :category}
  it {is_expected.to have_many(:answers).dependent :destroy}
  it {is_expected.to validate_presence_of :content}
  it {is_expected.to validate_presence_of :category_id}

  it do 
    is_expected.to accept_nested_attributes_for(:answers)
    .allow_destroy(true)
  end

  describe "#check_correct_answers_num" do
    subject(:question) {create :question}
    context "when no answers is correct" do
      before do 
        question.answers.each do |ans|
          ans.correct = false
        end
      end

      it do
        expect(question.check_correct_answers_num)
        .to include(I18n.t('question.failure.wrong_num_correct_answers',
           content: question.content))
      end
    end
  end
end
