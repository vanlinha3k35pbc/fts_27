class Admin::QuestionsController < ApplicationController
  before_action :check_admin

  def show
    @question = Question.find params[:id]
  end

  def new
    @category = Category.find params[:category_id]
    @question = @category.questions.build
    Settings.default_answers_num.times{@question.answers.build}
  end

  def edit
    @category = Category.find params[:category_id]
    @question = Question.find params[:id]
  end

  def create
    @category = Category.find params[:category_id]
    @question = @category.questions.build question_params

    if @question.save
      flash[:success] = I18n.t 'question.created'
      redirect_to [:admin, @category, @question]
    else
      flash.now[:danger] = I18n.t 'question.failure.created'
      render :new
    end
  end

  def update
    @category = Category.find params[:category_id]
    @question = Question.find params[:id]

    if @question.update_attributes question_params
      flash[:success] = I18n.t 'question.updated'
      redirect_to [:admin, @category, @question]
    else
      flash.now[:danger] = I18n.t 'question.failure.updated'
      render :edit
    end
  end

  def destroy
    @category = Category.find params[:category_id]
    Question.find(params[:id]).destroy
    flash[:success] = I18n.t 'question.deleted'
    redirect_to [:admin, @category]  
  end

  private 
  def question_params
    params.require(:question).permit(:content, answers_attributes:
     [:id, :content, :correct, :_destroy])
  end
end
