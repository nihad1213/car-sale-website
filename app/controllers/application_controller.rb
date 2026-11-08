# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def require_admin!
    unless current_user && current_user.admin?
      redirect_to admin_login_path, alert: "Unauthorized access. Please log in as an admin."
    end
  end
end
