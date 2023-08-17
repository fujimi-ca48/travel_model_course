class CreateRecommendedSpots < ActiveRecord::Migration[7.0]
  def change
    create_table :recommended_spots do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.string :address, null: false
      t.string :text
      t.float :latitude
      t.float :longitude
      t.string :img

      t.timestamps
    end
  end
end
