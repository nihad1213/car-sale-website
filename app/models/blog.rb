class Blog < ApplicationRecord
  ALLOWED_IMAGE_TYPES = %w[image/jpeg image/png image/webp].freeze
  MAX_IMAGE_SIZE = 5.megabytes

  has_one_attached :title_img
  has_rich_text :description

  belongs_to :creator, class_name: "User", foreign_key: "created_by", optional: true
  belongs_to :updater, class_name: "User", foreign_key: "updated_by", optional: true

  validates :header, presence: true, length: { maximum: 150 }
  validates :description, presence: true
  validates :title_img, presence: true, on: :create
  validate :title_img_is_valid

  scope :latest, -> { order(created_at: :desc) }

  def reading_time
    [ (description.to_plain_text.split.size / 200.0).ceil, 1 ].max
  end

  private

  def title_img_is_valid
    return unless title_img.attached?

    unless ALLOWED_IMAGE_TYPES.include?(title_img.blob.content_type)
      errors.add(:title_img, "must be a JPG, PNG or WebP image")
    end

    if title_img.blob.byte_size > MAX_IMAGE_SIZE
      errors.add(:title_img, "must be smaller than 5 MB")
    end
  end
end
