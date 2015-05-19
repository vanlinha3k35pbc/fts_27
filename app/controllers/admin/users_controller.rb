class Admin::UsersController < ApplicationController
  before_action :check_admin

  def index
    @q = User.ransack params[:q]
    @users = @q.result(distinct: true).paginate page: params[:page],
      per_page: Settings.users_per_page
    @q.build_condition
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to admin_users_url
  end
end
