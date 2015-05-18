class Admin::CategoriesController < ApplicationController
  before_action :check_admin

  def index
    @categories = Category.alphabet_sort.paginate page: params[:page],
      per_page: Settings.categories_per_page
  end

  def show
    @category = Category.find params[:id]
    @questions = @category.questions.alphabet_sort.paginate page: params[:page],
      per_page: Settings.questions_per_page
  end

  def new
    @category = Category.new
  end

  def edit
    @category = Category.find params[:id]
  end

  def create
    @category = Category.new category_params

    if @category.save
      flash[:success] = "Category created"
      redirect_to [:admin, @category]
    else
      flash.now[:danger] = "Can not create Category"
      render :new
    end
  end

  def update
    @category = Category.find params[:id]

    if @category.update_attributes category_params
      flash[:success] = "Category updated"
      redirect_to [:admin, @category]
    else
      flash.now[:danger] = "Can not update Category"
      render :edit
    end
  end

  def destroy
    Category.find(params[:id]).destroy
    flash[:success] = "Category deleted"
    redirect_to admin_categories_url  
  end

  private 
  def category_params
    params.require(:category).permit :name, :description
  end
end
