class Admin::SessionsController < ApplicationController
  def new
    render "admin/new"
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password]) && user.admin?
      session[:user_id] = user.id
      redirect_to admin_path, notice: "Logged in successfully as Admin!"
    else
      flash.now[:alert] = "Invalid email, password, or lack of admin privileges."
      render "admin/new", status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to admin_login_path, notice: "Logged out successfully."
  end
end
