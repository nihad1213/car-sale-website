module VehiclesHelper
  def filter_makes = Vehicle.distinct.order(:make).pluck(:make)
  def filter_body_types = BodyType.order(:name).pluck(:name)
  def filter_years = Date.current.year.downto(2000).to_a
end
