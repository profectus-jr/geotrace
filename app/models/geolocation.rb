class Geolocation < ApplicationRecord
  belongs_to :user

  validates :geolocation, presence: true
  validates :ip_address, presence: true, allow_nil: false, uniqueness: true

  scope :pages, -> (page) { limit(25).offset(25 * (page.to_i - 1))}
  
  scope :selected_fields, -> {
    select("geolocations.*").select("users.name, users.email")
  }

  scope :search_by_country, -> (country) { 
    where(geolocations: { country: country }) if country.present?
  }

  scope :search_by_city, -> (city) { 
    where(geolocations: { city: city }) if city.present?
  }

end
