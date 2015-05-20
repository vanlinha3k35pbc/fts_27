class Admin::CategoriesController < ApplicationController
  before_action :check_admin, only: :index
  load_and_authorize_resource

  def index
    @q = Category.ransack params[:q]
    @categories = @q.result(distinct: true).paginate page: params[:page],
      per_page: Settings.categories_per_page
    @q.build_condition
  end

  def show
    @questions = @category.questions.alphabet_sort.paginate page: params[:page],
      per_page: Settings.questions_per_page
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    if @category.save
      flash[:success] = "Category created"
      redirect_to [:admin, @category]
    else
      flash.now[:danger] = "Can not create Category"
      render :new
    end
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = "Category updated"
      redirect_to [:admin, @category]
    else
      flash.now[:danger] = "Can not update Category"
      render :edit
    end
  end

  def destroy
    @category.destroy
    flash[:success] = "Category deleted"
    redirect_to admin_categories_url  
  end

  private 
  def category_params
    params.require(:category).permit :name, :description
  end
end
