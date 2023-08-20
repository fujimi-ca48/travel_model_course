# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_08_19_125011) do
  create_table "model_courses", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "name", null: false
    t.integer "all_time", null: false
    t.string "spot_item_data", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_model_courses_on_user_id"
  end

  create_table "recommended_spots", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "name", null: false
    t.string "address", null: false
    t.string "text"
    t.float "latitude"
    t.float "longitude"
    t.string "img"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_recommended_spots_on_user_id"
  end

  create_table "total_spot_items", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "recommended_spot_id"
    t.integer "tourist_spot_id"
    t.integer "duration", null: false
    t.integer "transportation", null: false
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recommended_spot_id"], name: "index_total_spot_items_on_recommended_spot_id"
    t.index ["tourist_spot_id"], name: "index_total_spot_items_on_tourist_spot_id"
    t.index ["user_id"], name: "index_total_spot_items_on_user_id"
  end

  create_table "tourist_spots", force: :cascade do |t|
    t.string "name", null: false
    t.string "address", null: false
    t.text "text"
    t.float "latitude"
    t.float "longitude"
    t.string "spot_image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "model_courses", "users"
  add_foreign_key "recommended_spots", "users"
  add_foreign_key "total_spot_items", "recommended_spots"
  add_foreign_key "total_spot_items", "tourist_spots"
  add_foreign_key "total_spot_items", "users"
end
