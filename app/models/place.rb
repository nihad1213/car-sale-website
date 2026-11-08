class Place < ApplicationRecord
  has_many :vehicles, dependent: :restrict_with_error

  belongs_to :creator, class_name: "User", foreign_key: "created_by", optional: true
  belongs_to :updater, class_name: "User", foreign_key: "updated_by", optional: true

  validates :name, presence: true, uniqueness: true
end
