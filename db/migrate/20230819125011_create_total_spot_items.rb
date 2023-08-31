class CreateTotalSpotItems < ActiveRecord::Migration[7.0]
  def change
    create_table :total_spot_items do |t|
      t.references :user, null: false, foreign_key: true
      t.references :recommended_spot, foreign_key: true
      t.references :tourist_spot, foreign_key: true
      t.integer :duration, null: false
      t.integer :transportation, default: 0, null: false
      t.integer :position

      t.timestamps
    end
  end
end
