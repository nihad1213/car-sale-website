class VehiclesController < ApplicationController
  before_action :require_login, except: :show
  before_action :set_own_vehicle, only: %i[edit update destroy]
  before_action :load_form_options, only: %i[new create edit update]

  def show
    @vehicle = Vehicle.with_attached_pics.includes(:body_type, :place).find(params[:id])
    @favorite_ids = current_user ? current_user.favorites.pluck(:vehicle_id) : []
  end

  def mine
    @vehicles = Vehicle.where(created_by: current_user.id).includes(:place).with_attached_pics.order(created_at: :desc)
    @favorite_ids = current_user.favorites.pluck(:vehicle_id)
  end

  def new
    @vehicle = Vehicle.new
  end

  def create
    @vehicle = Vehicle.new(vehicle_params)
    @vehicle.creator = current_user
    @vehicle.updater = current_user

    if @vehicle.save
      redirect_to vehicle_path(@vehicle), notice: "Your car was listed successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @vehicle.updater = current_user

    if @vehicle.update(vehicle_params)
      redirect_to vehicle_path(@vehicle), notice: "Listing was updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @vehicle.destroy
    redirect_to mine_vehicles_path, notice: "Listing was deleted."
  end

  private

  def set_own_vehicle
    scope = current_user.admin? ? Vehicle : Vehicle.where(created_by: current_user.id)
    @vehicle = scope.find(params[:id])
  end

  def load_form_options
    @body_types = BodyType.order(:name)
    @places = Place.order(:name)
  end

  def vehicle_params
    permitted = params.require(:vehicle).permit(
      :title, :make, :model, :year, :price, :mileage, :fuel, :transmission,
      :description, :body_type_id, :place_id, pics: []
    )
    permitted[:pics] = permitted[:pics].compact_blank if permitted.key?(:pics)
    permitted.delete(:pics) if permitted[:pics].blank? && @vehicle&.persisted?
    permitted
  end
end
