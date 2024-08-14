class AddColumnUserIdToGeolocations < ActiveRecord::Migration[7.1]
  def change
    add_reference :geolocations, :user, null: false, foreign_key: true
  end
end
