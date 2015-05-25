require 'rails_helper'
include Devise::TestHelpers

RSpec.describe Admin::CategoriesController, :type => :controller do
  let(:admin) {create :admin}
  let(:category) {create :category}
  it do
    is_expected.to use_before_action :check_admin
  end

  context "when user is an admin" do
    before do
      sign_in admin
    end
 

    it do
      is_expected.to permit(:name, :description).for(:create)
    end    

    describe "GET index" do
      before {get :index}

      # it "populates an array of categories" do
      #   expect(assigns :categories).to include([category])
      # end

      it {expect(response).to render_template :index}
    end

    describe "GET show" do
      before do
        get :show, id: category
      end

      it "assigns the requested category to @category" do
        expect(assigns :category).to eql category
      end

      it "assigns the requested category's questions to @questions" do
        expect(assigns :questions).to eq category.questions.alphabet_sort
          .paginate(page: '1', per_page: Settings.questions_per_page)
      end

      it {expect(response).to render_template :show}
    end

    describe "GET new" do
      before {get :new}

      it "assigns a new Category to @category" do
        expect(assigns :category).to be_a_new Category
      end

      it {expect(response).to render_template :new}
    end

    describe "POST create" do
      context "when attributes valid" do
        before do
          post :create, category: attributes_for(:category)
        end

        it "saves the new category in the database" do
          expect(response).to change(Category, :count).by(1)
        end

        it "redirect to assigned category" do
          expect(response).to redirect_to [:admin, (assigns :category)]
        end

        it {expect(response).to render_template(:show)}
        it {expect(response.body).to include "Category created"}
      end
    end
  end
end
