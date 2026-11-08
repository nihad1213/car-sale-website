class AdminController < ApplicationController
  before_action :require_admin!

  def index
  end


  def require_admin!
    current_user = User.find_by(id: session[:user_id])

    unless current_user && current_user.admin?
      redirect_to admin_login_path, alert: "You must be logged in as an admin to access this page."
    end
  end
end
