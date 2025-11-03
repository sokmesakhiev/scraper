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

ActiveRecord::Schema[8.1].define(version: 2025_11_03_073542) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "keyword_files", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.string "original_file"
    t.string "status"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["name"], name: "index_keyword_files_on_name"
    t.index ["user_id"], name: "index_keyword_files_on_user_id"
  end

  create_table "keyword_results", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "html_code"
    t.bigint "keyword_id", null: false
    t.integer "total_ads"
    t.integer "total_links"
    t.datetime "updated_at", null: false
    t.index ["keyword_id"], name: "index_keyword_results_on_keyword_id"
  end

  create_table "keywords", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "keyword", null: false
    t.bigint "keyword_file_id", null: false
    t.string "status"
    t.datetime "updated_at", null: false
    t.index ["keyword_file_id"], name: "index_keywords_on_keyword_file_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "provider"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.string "uid"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid"], name: "index_users_on_uid"
  end

  add_foreign_key "keyword_files", "users"
  add_foreign_key "keyword_results", "keywords"
  add_foreign_key "keywords", "keyword_files"
end
