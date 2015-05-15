class Admin::ExamsController < ApplicationController
  before_action :check_admin

  def index
    @exams = Exam.created_sort.paginate page: params[:page],
      per_page: Settings.exams_per_page
  end

  def destroy
    Exam.find(params[:id]).destroy
    flash[:success] = I18n.t "exam.deleted"
    redirect_to admin_exams_url
  end
end
