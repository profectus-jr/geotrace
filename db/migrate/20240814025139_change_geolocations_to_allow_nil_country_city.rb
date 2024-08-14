class ChangeGeolocationsToAllowNilCountryCity < ActiveRecord::Migration[7.1]
  def change
    change_column_null :geolocations, :country, true
    change_column_null :geolocations, :city, true
  end
end
