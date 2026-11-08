class Vehicle < ApplicationRecord
  belongs_to :body_type
  belongs_to :place

  belongs_to :creator, class_name: "User", foreign_key: "created_by", optional: true
  belongs_to :updater, class_name: "User", foreign_key: "updated_by", optional: true

  has_many_attached :pics

  validates :title, :make, :year, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  validate :validate_pic_count

  private

  def validate_pic_count
    if pics.attached?
      if pics.length > 12
        errors.add(:pics, "cannot exceed 12 images")
      elsif pics.length < 1
        errors.add(:pics, "must include at least 1 image")
      end
    else
      errors.add(:pics, "must attach at least 1 image")
    end
  end
end
