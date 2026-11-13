class FavoritesController < ApplicationController
  before_action :require_login
  before_action :set_vehicle, only: %i[create destroy]

  def index
    @vehicles = current_user.favorite_vehicles.includes(:place).with_attached_pics
                            .order("favorites.created_at DESC")
    @favorite_ids = @vehicles.map(&:id)
  end

  def create
    current_user.favorites.find_or_create_by!(vehicle: @vehicle)
    respond
  end

  def destroy
    current_user.favorites.where(vehicle: @vehicle).destroy_all
    respond
  end

  private

  def set_vehicle
    @vehicle = Vehicle.find(params[:vehicle_id])
  end

  def respond
    ids = current_user.favorites.pluck(:vehicle_id)
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          helpers.dom_id(@vehicle, :favorite),
          partial: "favorites/button", locals: { vehicle: @vehicle, favorite_ids: ids }
        )
      end
      format.html { redirect_back fallback_location: root_path }
    end
  end
end
