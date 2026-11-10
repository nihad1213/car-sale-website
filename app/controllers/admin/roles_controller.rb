# app/controllers/admin/roles_controller.rb
class Admin::RolesController < ApplicationController
  before_action :require_admin!
  before_action :set_role, only: %i[show edit update destroy]
  before_action :load_permissions, only: %i[new create edit update]

  def index
    @roles = Role.includes(:permissions, :users).order(:name)
  end

  def show
  end

  def new
    @role = Role.new
  end

  def create
    @role = Role.new(role_params)
    @role.creator = current_user
    @role.updater = current_user

    if @role.save
      redirect_to admin_role_path(@role), notice: "Role was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @role.updater = current_user

    if @role.update(role_params)
      redirect_to admin_role_path(@role), notice: "Role was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @role.users.exists?
      redirect_to admin_roles_path, alert: "Cannot delete a role that is assigned to users."
    else
      @role.destroy
      redirect_to admin_roles_path, notice: "Role was successfully deleted."
    end
  end

  private

  def set_role
    @role = Role.find(params[:id])
  end

  def load_permissions
    @permissions = Permission.order(:name)
  end

  def role_params
    params.require(:role).permit(:name, permission_ids: [])
  end
end
