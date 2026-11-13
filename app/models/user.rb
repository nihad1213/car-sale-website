class User < ApplicationRecord
  has_secure_password

  belongs_to :role

  belongs_to :creator, class_name: "User", foreign_key: "created_by", optional: true
  belongs_to :updater, class_name: "User", foreign_key: "updated_by", optional: true

  has_many :vehicles, foreign_key: "created_by", dependent: :nullify
  has_many :body_types, foreign_key: "created_by", dependent: :nullify
  has_many :places, foreign_key: "created_by", dependent: :nullify

  has_many :favorites, dependent: :destroy
  has_many :favorite_vehicles, through: :favorites, source: :vehicle

  def admin?
    role&.name == "Admin"
  end
end
