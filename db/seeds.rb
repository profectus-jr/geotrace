# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

trackers = [
  {
    name: "Jane",
    email: "janen@mail.com",
    password: "1q2w3e4r"
  },
  {
    name: "John",
    email: "johnn@mail.com",
    password: "1q2w3e4r"
  },
]

trackers.each do |tracker|
  User.create!(tracker)
end

geolocations = [
  {"ip": "134.201.250.155", "type": "ipv4", "continent_code": "NA", "continent_name": "North America", "country_code": "US", "country_name": "United States", "region_code": "CA", "region_name": "California", "city": "Los Angeles", "zip": "90012", "latitude": 34.0655517578125, "longitude": -118.24053955078125, "msa": "31100", "dma": "803", "location": {"geoname_id": 5368361, "capital": "Washington D.C.", "languages": [{"code": "en", "name": "English", "native": "English"}], "country_flag": "https://assets.ipstack.com/flags/us.svg", "calling_code": "1", "is_eu": false}},
  {"ip": "205.63.21.158", "type": "ipv4", "continent_code": "NA", "continent_name": "North America", "country_code": "US", "country_name": "United States", "region_code": "VA", "region_name": "Virginia", "city": "Virginia Beach", "zip": "23459", "latitude": 36.92033004760742, "longitude": -76.01876831054688, "msa": "47260", "dma": "544", "ip_routing_type": "fixed", "connection_type": "tx", "location": {"geoname_id": 4791259, "capital": "Washington D.C.", "languages": [{"code": "en", "name": "English", "native": "English"}], "country_flag": "https://assets.ipstack.com/flags/us.svg", "calling_code": "1", "is_eu": false}}
]

geolocations.each do |geo|
  usr = User.find_by(email: "john@mail.com")
  Geolocation.create!(
    user_id: usr.id,
    geolocation: geo,
    city: geo[:city],
    ip_address: geo[:ip],
    country: geo[:country_name]
  )
end
