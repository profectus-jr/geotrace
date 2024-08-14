class AddColumnCityAndCountryToGeolocations < ActiveRecord::Migration[7.1]
  def change
    add_column :geolocations, :country, :string, null: false
    add_column :geolocations, :city, :string, null: false
  end
end
