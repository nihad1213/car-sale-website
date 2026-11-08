class ApplicationController < ActionController::Base
  helper_method :current_user, :site_config

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def require_admin!
    unless current_user && current_user.admin?
      redirect_to admin_login_path, alert: "Unauthorized access. Please log in as an admin."
    end
  end

  def site_config
    @site_config ||= SiteConfiguration.first_or_create!
  end
end
