# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_11_12_185000) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: :cascade do |t|
    t.string "uid"
    t.string "token"
    t.string "provider"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_authentications_on_user_id"
  end

  create_table "business_hours", force: :cascade do |t|
    t.bigint "business_id"
    t.integer "day"
    t.time "open_time"
    t.time "close_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_business_hours_on_business_id"
  end

  create_table "businesses", force: :cascade do |t|
    t.string "name"
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "phone"
    t.integer "zipcode"
    t.string "email"
    t.string "facebook"
    t.string "instagram"
    t.string "youtube"
    t.string "twitter"
    t.string "logo"
    t.string "operator"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "landings", force: :cascade do |t|
    t.string "title"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "off_days", force: :cascade do |t|
    t.integer "day_off"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "promotions", force: :cascade do |t|
    t.string "title"
    t.string "advert"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reservations", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "service_id"
    t.boolean "force_create"
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "phone_number"
    t.date "reservation_date"
    t.time "reservation_time"
    t.time "end_time"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.integer "stylist_id"
    t.index ["service_id"], name: "index_reservations_on_service_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.bigint "off_day_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["off_day_id"], name: "index_schedules_on_off_day_id"
    t.index ["user_id"], name: "index_schedules_on_user_id"
  end

  create_table "service_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "services", force: :cascade do |t|
    t.bigint "service_type_id"
    t.string "name"
    t.text "description"
    t.integer "price"
    t.integer "length"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["service_type_id"], name: "index_services_on_service_type_id"
  end

  create_table "skills", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "service_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["service_id"], name: "index_skills_on_service_id"
    t.index ["user_id"], name: "index_skills_on_user_id"
  end

  create_table "stamps", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "stamper_id"
    t.boolean "redeemed"
    t.index ["user_id"], name: "index_stamps_on_user_id"
  end

  create_table "titles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "last_name"
    t.string "first_name"
    t.string "email", null: false
    t.string "gender"
    t.date "birthday"
    t.string "phone_number"
    t.integer "role", default: 0
    t.bigint "title_id"
    t.string "instagram"
    t.string "facebook"
    t.string "linkedin"
    t.string "avatar"
    t.text "notes"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title_id"], name: "index_users_on_title_id"
  end

  add_foreign_key "authentications", "users"
  add_foreign_key "business_hours", "businesses"
  add_foreign_key "reservations", "services"
  add_foreign_key "reservations", "users"
  add_foreign_key "services", "service_types"
  add_foreign_key "stamps", "users"
  add_foreign_key "users", "titles"
end
