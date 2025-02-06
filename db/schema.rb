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

ActiveRecord::Schema[7.1].define(version: 2025_02_06_123226) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories_crates", id: false, force: :cascade do |t|
    t.bigint "crate_id", null: false
    t.bigint "category_id", null: false
  end

  create_table "categories_events", id: false, force: :cascade do |t|
    t.bigint "event_id", null: false
    t.bigint "category_id", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "post_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "crates", force: :cascade do |t|
    t.bigint "farmer_id", null: false
    t.boolean "flash_sale", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "price", precision: 10, scale: 2
    t.string "name"
    t.string "description"
    t.float "latitude"
    t.float "longitude"
    t.bigint "event_id"
    t.index ["event_id"], name: "index_crates_on_event_id"
    t.index ["farmer_id"], name: "index_crates_on_farmer_id"
  end

  create_table "event_attendances", force: :cascade do |t|
    t.bigint "farmer_id", null: false
    t.bigint "event_id", null: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_attendances_on_event_id"
    t.index ["farmer_id"], name: "index_event_attendances_on_farmer_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.bigint "farmer_id", null: false
    t.string "location"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "category"
    t.float "latitude"
    t.float "longitude"
    t.index ["farmer_id"], name: "index_events_on_farmer_id"
  end

  create_table "farmers", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "bio"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
    t.string "name"
    t.index ["user_id"], name: "index_farmers_on_user_id"
  end

  create_table "follows", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "farmer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["farmer_id"], name: "index_follows_on_farmer_id"
    t.index ["user_id"], name: "index_follows_on_user_id"
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_likes_on_post_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.bigint "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "crate_id", null: false
    t.index ["crate_id"], name: "index_orders_on_crate_id"
    t.index ["event_id"], name: "index_orders_on_event_id"
  end

  create_table "posts", force: :cascade do |t|
    t.bigint "farmer_id", null: false
    t.text "caption"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["farmer_id"], name: "index_posts_on_farmer_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.bigint "crate_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "quantity"
    t.index ["crate_id"], name: "index_products_on_crate_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "content"
    t.integer "rating"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "farmer_id", null: false
    t.bigint "user_id"
    t.index ["farmer_id"], name: "index_reviews_on_farmer_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "username"
    t.string "avatar"
    t.string "role", default: "standard"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "users"
  add_foreign_key "crates", "events"
  add_foreign_key "crates", "farmers"
  add_foreign_key "event_attendances", "events"
  add_foreign_key "event_attendances", "farmers"
  add_foreign_key "events", "farmers"
  add_foreign_key "farmers", "users"
  add_foreign_key "follows", "farmers"
  add_foreign_key "follows", "users"
  add_foreign_key "likes", "posts"
  add_foreign_key "likes", "users"
  add_foreign_key "orders", "crates"
  add_foreign_key "orders", "events"
  add_foreign_key "posts", "farmers"
  add_foreign_key "products", "crates"
  add_foreign_key "reviews", "farmers"
  add_foreign_key "reviews", "users"
end
