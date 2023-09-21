class CreateBookmarks < ActiveRecord::Migration[7.0]
  def change
    create_table :bookmarks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :model_course, null: false, foreign_key: true

      t.timestamps
    end
    add_index :bookmarks, [:user_id, :model_course_id], unique: :true
  end
end
