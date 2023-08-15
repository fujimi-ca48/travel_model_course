class CreateTouristSpots < ActiveRecord::Migration[7.0]
  def change
    create_table :tourist_spots do |t|
      t.string :name, null: false
      t.string :address, null: false
      t.text :text
      t.float :latitude
      t.float :longitude
      t.string :spot_image

      t.timestamps
    end
  end
end
