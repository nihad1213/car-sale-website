class ApplicationController < ActionController::Base
  helper_method :current_user, :site_config, :body_types

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

  def body_types
    @body_types ||= BodyType.order(:name)
  end

  def require_login
    return if current_user.present?

    flash[:open_auth_modal] = true
    flash[:auth_error] = "Please sign in to continue."
    redirect_to root_path
  end
end
