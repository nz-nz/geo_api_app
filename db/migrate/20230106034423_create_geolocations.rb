class CreateGeolocations < ActiveRecord::Migration[7.0]
  def change
    create_table :geolocations do |t|
      t.string :ip
      t.float :longitude
      t.float :latitude
      t.string :address

      t.timestamps
    end
  end
end
