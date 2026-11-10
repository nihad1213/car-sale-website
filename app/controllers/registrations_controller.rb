class RegistrationsController < ApplicationController
  USER_ROLE_ID = 2

  def create
    @user = User.new(registration_params)
    @user.role_id = USER_ROLE_ID

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Welcome, #{@user.first_name}!"
    else
      flash[:open_auth_modal] = true
      flash[:auth_tab] = "register"
      flash[:auth_error] = @user.errors.full_messages.to_sentence
      redirect_back fallback_location: root_path
    end
  end

  private

  def registration_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
