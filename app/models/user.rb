class User < ApplicationRecord
  has_secure_password

  belongs_to :role

  belongs_to :creator, class_name: "User", foreign_key: "created_by", optional: true
  belongs_to :updater, class_name: "User", foreign_key: "updated_by", optional: true

  def admin?
    role&.name == "Admin"
  end
end
