class Admin::UsersController < ApplicationController
  before_action :check_admin

  def index
    @users = User.paginate page: params[:page], per_page: Settings.users_per_page
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to admin_users_url
  end
end
