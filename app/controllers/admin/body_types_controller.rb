class Admin::BodyTypesController < ApplicationController
  before_action :require_admin!
  before_action :set_body_type, only: %i[show edit update destroy]

  def index
    @body_types = BodyType.includes(:vehicles).order(:name)
  end

  def show
  end

  def new
    @body_type = BodyType.new
  end

  def create
    @body_type = BodyType.new(body_type_params)
    @body_type.creator = current_user
    @body_type.updater = current_user

    if @body_type.save
      redirect_to admin_body_type_path(@body_type), notice: "Body type was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @body_type.updater = current_user

    if @body_type.update(body_type_params)
      redirect_to admin_body_type_path(@body_type), notice: "Body type was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @body_type.destroy
      redirect_to admin_body_types_path, notice: "Body type was successfully deleted."
    else
      redirect_to admin_body_types_path,
                  alert: @body_type.errors.full_messages.to_sentence.presence || "Could not delete this body type."
    end
  end

  private

  def set_body_type
    @body_type = BodyType.find(params[:id])
  end

  def body_type_params
    params.require(:body_type).permit(:name, :icon)
  end
end
