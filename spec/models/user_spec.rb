require 'rails_helper'

RSpec.describe User, :type => :model do
  it {expect(create :user).to be_valid}

  describe "has a valid factory admin" do
    let(:admin) {create :admin}
    it {expect(admin).to be_valid}
    it {expect(admin.admin?).to be true}
  end
end
