class CreateModelCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :model_courses do |t|
      t.string :name
      t.integer :all_time

      t.timestamps
    end
  end
end
