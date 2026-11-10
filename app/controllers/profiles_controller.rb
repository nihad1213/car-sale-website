class ProfilesController < ApplicationController
  before_action :require_login

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    unless @user.authenticate(params[:current_password].to_s)
      @user.assign_attributes(profile_params.except(:password, :password_confirmation))
      @user.errors.add(:base, "Current password is incorrect")
      return render :edit, status: :unprocessable_entity
    end

    if @user.update(profile_params)
      redirect_to profile_path, notice: "Profile updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def profile_params
    permitted = params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    permitted.delete_if { |k, v| k.start_with?("password") && v.blank? }
  end
end
