class ContactMessage < ApplicationRecord
  SUBJECTS = [
    "General question",
    "Question about a listing",
    "Selling my car",
    "Report a problem"
  ].freeze

  validates :name, presence: true, length: { maximum: 100 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :subject, inclusion: { in: SUBJECTS }
  validates :message, presence: true, length: { minimum: 10, maximum: 3000 }

  scope :latest, -> { order(created_at: :desc) }
  scope :unread, -> { where(read_at: nil) }

  def read?
    read_at.present?
  end

  def mark_as_read!
    update_column(:read_at, Time.current) unless read?
  end
end
