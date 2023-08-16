class CreateSelectedTouristSpots < ActiveRecord::Migration[7.0]
  def change
    create_table :selected_tourist_spots do |t|
      t.references :user, null: false, foreign_key: true
      t.references :tourist_spot, null: false, foreign_key: true

      t.timestamps
    end
  end
end
