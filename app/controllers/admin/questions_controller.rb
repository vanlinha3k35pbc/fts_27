class Admin::QuestionsController < ApplicationController
  load_and_authorize_resource :category
  load_and_authorize_resource through: :category

  def show
  end

  def new
    Settings.default_answers_num.times{@question.answers.build}
  end

  def edit
  end

  def create
    if @question.save
      flash[:success] = I18n.t 'question.created'
      redirect_to [:admin, @category, @question]
    else
      flash.now[:danger] = I18n.t 'question.failure.created'
      render :new
    end
  end

  def update
    if @question.update_attributes question_params
      flash[:success] = I18n.t 'question.updated'
      redirect_to [:admin, @category, @question]
    else
      flash.now[:danger] = I18n.t 'question.failure.updated'
      render :edit
    end
  end

  def destroy
    @question.destroy
    flash[:success] = I18n.t 'question.deleted'
    redirect_to [:admin, @category]  
  end

  private 
  def question_params
    params.require(:question).permit(:content, answers_attributes:
     [:id, :content, :correct, :_destroy])
  end
end
