class ExamsController < ApplicationController
  def index
    @exam = Exam.new
    @exams = current_user.exams.created_sort
      .paginate page: params[:page], per_page: 5
  end 

  def new
  end

  def create
    category = Category.find params[:exam][:category_id]
    exam = category.exams.build 
    exam.user_id = current_user.id
    if exam.save
      flash[:success] = t("flash.exam_created")
      redirect_to exams_path
    else
      render :new
    end
  end

  def edit
    @exam = Exam.find params[:id]

    if @exam.started_time.nil?
      started_time = Time.zone.now
      @exam.update_attributes status: "view", started_time: started_time
    end
    @timeleft = Settings.allow_period*60 - (Time.zone.now - @exam.started_time).to_i
  end

  def update
    @exam = Exam.find params[:id]
    if @exam.update_attributes answersheet_params
      flash[:success] = t("flash.ans_sheet_update")
      redirect_to edit_exam_path @exam
    else
      redirect_to :back
    end
  end

  private
  def answersheet_params
    params.require(:exam).permit answersheets_attributes: [:id, :answer_id]
  end
end
