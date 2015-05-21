require 'rails_helper'

describe Category do
  it {is_expected.to have_many(:questions).dependent :destroy}
  it {is_expected.to have_many(:exams).dependent :destroy}
  it {expect(create :category).to be_valid}

  describe "#name" do
    it {is_expected.to validate_presence_of :name}
    it {is_expected.to validate_uniqueness_of :name}
  end

  describe "#description" do
    it {is_expected.to validate_presence_of :description}
  end
end
