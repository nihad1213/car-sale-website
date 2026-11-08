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

ActiveRecord::Schema[8.1].define(version: 2026_11_08_215712) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "permissions", force: :cascade do |t|
    t.string "name"
    t.bigint "created_by"
    t.bigint "updated_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "permissions_roles", id: false, force: :cascade do |t|
    t.bigint "permission_id", null: false
    t.bigint "role_id", null: false
    t.index ["permission_id", "role_id"], name: "index_permissions_roles_on_permission_id_and_role_id"
    t.index ["role_id", "permission_id"], name: "index_permissions_roles_on_role_id_and_permission_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.bigint "created_by"
    t.bigint "updated_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "site_configurations", force: :cascade do |t|
    t.string "site_name"
    t.string "tagline"
    t.string "phone_number"
    t.string "email"
    t.text "address"
    t.string "meta_title"
    t.text "meta_description"
    t.string "meta_keywords"
    t.string "canonical_url"
    t.string "robots", default: "index, follow"
    t.string "og_title"
    t.text "og_description"
    t.string "og_image_url"
    t.string "og_type", default: "website"
    t.string "twitter_card", default: "summary_large_image"
    t.string "twitter_site"
    t.string "google_analytics_id"
    t.string "google_site_verification"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "listings_count"
    t.string "dealers_count"
    t.string "satisfaction_rate"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.bigint "role_id"
    t.bigint "created_by"
    t.bigint "updated_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "users", "roles"
end
