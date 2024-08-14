class User < ApplicationRecord

  has_secure_password

  has_many :geolocations, dependent: :destroy

  validates :password_digest, presence: true
  validates :name, presence: true, allow_nil: false, length: { minimum: 2 }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  enum status: { active: 1, inactive: 0 }

end
