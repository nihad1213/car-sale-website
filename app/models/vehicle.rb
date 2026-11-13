class Vehicle < ApplicationRecord
  FUELS = %w[Petrol Diesel Hybrid Electric].freeze
  TRANSMISSIONS = %w[Automatic Manual].freeze
  ALLOWED_PIC_TYPES = %w[image/jpeg image/png image/webp].freeze
  MAX_PIC_SIZE = 5.megabytes

  SORTS = {
    "newest"     => { created_at: :desc },
    "price_asc"  => { price: :asc },
    "price_desc" => { price: :desc },
    "year_desc"  => { year: :desc },
    "mileage"    => { mileage: :asc }
  }.freeze

  belongs_to :body_type
  belongs_to :place

  belongs_to :creator, class_name: "User", foreign_key: "created_by", optional: true
  belongs_to :updater, class_name: "User", foreign_key: "updated_by", optional: true

  has_many :favorites, dependent: :destroy
  has_many_attached :pics

  validates :title, :make, :year, :price, presence: true
  validates :title, length: { maximum: 120 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :year, numericality: { only_integer: true, greater_than_or_equal_to: 1950,
                                   less_than_or_equal_to: -> { Date.current.year + 1 } }
  validates :mileage, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
  validates :fuel, inclusion: { in: FUELS }, allow_blank: true
  validates :transmission, inclusion: { in: TRANSMISSIONS }, allow_blank: true

  validate :validate_pic_count
  validate :validate_pic_files

  def self.filter_by(params)
    scope = all

    if params[:q].present?
      term = "%#{sanitize_sql_like(params[:q].to_s.strip.downcase)}%"
      scope = scope.where(
        "LOWER(vehicles.title) LIKE :t OR LOWER(vehicles.make) LIKE :t OR LOWER(vehicles.model) LIKE :t", t: term
      )
    end

    scope = scope.where(make: params[:make]) if params[:make].present?

    if params[:model].present?
      term = "%#{sanitize_sql_like(params[:model].to_s.strip.downcase)}%"
      scope = scope.where("LOWER(vehicles.model) LIKE ?", term)
    end

    scope = scope.where("vehicles.year >= ?", params[:year_from].to_i) if params[:year_from].present?
    scope = scope.where("vehicles.year <= ?", params[:year_to].to_i)   if params[:year_to].present?
    scope = scope.where("vehicles.price >= ?", params[:price_min].to_f) if params[:price_min].present?
    scope = scope.where("vehicles.price <= ?", params[:price_max].to_f) if params[:price_max].present?
    scope = scope.where(fuel: params[:fuel]) if params[:fuel].present?

    if params[:body_type].present?
      scope = scope.joins(:body_type).where(body_types: { name: params[:body_type] })
    end

    scope
  end

  def self.sorted_by(key)
    order(SORTS.fetch(key.to_s, SORTS["newest"]))
  end

  private

  def validate_pic_count
    if !pics.attached?
      errors.add(:pics, "must attach at least 1 image")
    elsif pics.length > 12
      errors.add(:pics, "cannot exceed 12 images")
    end
  end

  def validate_pic_files
    return unless pics.attached?

    if pics.any? { |p| !ALLOWED_PIC_TYPES.include?(p.blob.content_type) }
      errors.add(:pics, "must be JPG, PNG or WebP images")
    end
    if pics.any? { |p| p.blob.byte_size > MAX_PIC_SIZE }
      errors.add(:pics, "must each be smaller than 5 MB")
    end
  end
end
