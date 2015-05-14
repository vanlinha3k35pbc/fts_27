class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:account_update) do |u| 
      u.permit :name, :email, :password, :password_confirmation,
        :current_password, :avatar, :avatar_cache
    end
  end

  def check_admin
    if self.class.name.split("::").first == "Admin"
      redirect_to(root_url, alert: I18n.t('admin.failure.permission_denied')) unless (user_signed_in? && current_user.admin?)
    end
  end

end
