class CreateGeolocations < ActiveRecord::Migration[7.1]
  def change
    create_table :geolocations do |t|
      t.string :ip_address, null: false
      t.string :url
      t.jsonb :geolocation, null: false
      t.datetime :created_at, default: -> { 'CURRENT_TIMESTAMP(6)' }

      t.index [ :ip_address ], unique: true
    end
  end
end
