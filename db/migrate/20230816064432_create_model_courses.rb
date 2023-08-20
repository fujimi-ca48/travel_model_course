class CreateModelCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :model_courses do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.integer :all_time, null: false
      t.string :spot_item_data, null: false

      t.timestamps
    end
  end
end
8