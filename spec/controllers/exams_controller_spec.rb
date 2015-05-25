require 'rails_helper'

RSpec.describe ExamsController, :type => :controller do
  it do
    should permit(:category_id).for(:create)
  end
end
