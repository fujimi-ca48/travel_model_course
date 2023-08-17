class AddRowOrderToModelCourses < ActiveRecord::Migration[7.0]
  def change
    add_column :model_courses, :row_order, :integer
  end
end
