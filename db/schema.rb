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

ActiveRecord::Schema.define(version: 2019_05_11_180747) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.text "note"
    t.float "current_value", null: false
    t.datetime "inactivated_at"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "user_id"], name: "index_accounts_on_name_and_user_id", unique: true
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.integer "eligible_mode", null: false
    t.datetime "inactivated_at"
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "expense_logs", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "account_id", null: false
    t.bigint "category_id", null: false
    t.float "amount", null: false
    t.text "note", null: false
    t.integer "mode", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_expense_logs_on_account_id"
    t.index ["category_id"], name: "index_expense_logs_on_category_id"
    t.index ["user_id"], name: "index_expense_logs_on_user_id"
  end

  create_table "internal_transfer_logs", force: :cascade do |t|
    t.bigint "source_account_id", null: false
    t.bigint "destination_account_id", null: false
    t.bigint "expense_log_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["destination_account_id"], name: "index_internal_transfer_logs_on_destination_account_id"
    t.index ["expense_log_id"], name: "index_internal_transfer_logs_on_expense_log_id"
    t.index ["source_account_id"], name: "index_internal_transfer_logs_on_source_account_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "accounts", "users"
  add_foreign_key "categories", "users"
  add_foreign_key "expense_logs", "accounts"
  add_foreign_key "expense_logs", "categories"
  add_foreign_key "expense_logs", "users"
  add_foreign_key "internal_transfer_logs", "accounts", column: "destination_account_id"
  add_foreign_key "internal_transfer_logs", "accounts", column: "source_account_id"
  add_foreign_key "internal_transfer_logs", "expense_logs"
end
