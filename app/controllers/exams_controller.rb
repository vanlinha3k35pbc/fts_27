class ExamsController < ApplicationController
  def index
    @exam = Exam.new
    @exams = current_user.exams.created_sort
      .paginate page: params[:page], per_page: 5
  end

  def new
  end

  def create
    @exam = Exam.new exam_params
    if @exam.save
      flash[:success] = t('flash.exam_created')
      redirect_to exams_path
    else
      render :new
    end
  end

  private
  def exam_params
    params.required(:exam).permit :user_id, :category_id, :result, 
      :started_time, :status
  end
end
