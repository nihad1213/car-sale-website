class SessionsController < ApplicationController
  def new
    redirect_to root_path(open_auth: 1)
  end

  def create
    user = User.find_by(email: params[:email].to_s.strip.downcase)

    if user&.authenticate(params[:password].to_s)
      reset_session
      session[:user_id] = user.id
      redirect_to root_path, notice: "Welcome back, #{user.first_name}!"
    else
      flash[:open_auth_modal] = true
      flash[:auth_tab] = "login"
      flash[:auth_error] = "Invalid email or password."
      redirect_back fallback_location: root_path
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: "Signed out."
  end
end
