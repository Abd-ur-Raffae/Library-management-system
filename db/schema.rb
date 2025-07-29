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

ActiveRecord::Schema[8.0].define(version: 2025_07_29_044725) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "authors", force: :cascade do |t|
    t.string "name"
    t.text "biography"
    t.date "birth_date"
    t.string "nationality"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "book_requests", force: :cascade do |t|
    t.bigint "book_id", null: false
    t.bigint "member_id"
    t.bigint "requested_by_id", null: false
    t.date "requested_date"
    t.date "needed_by_date"
    t.string "status"
    t.text "reason"
    t.bigint "approved_by_id"
    t.date "approved_date"
    t.text "rejection_reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["approved_by_id"], name: "index_book_requests_on_approved_by_id"
    t.index ["book_id"], name: "index_book_requests_on_book_id"
    t.index ["member_id"], name: "index_book_requests_on_member_id"
    t.index ["requested_by_id"], name: "index_book_requests_on_requested_by_id"
  end

  create_table "books", force: :cascade do |t|
    t.string "title"
    t.string "isbn"
    t.integer "publication_year"
    t.string "genre"
    t.text "description"
    t.boolean "available"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "author_id", null: false
    t.index ["author_id"], name: "index_books_on_author_id"
  end

  create_table "borrowings", force: :cascade do |t|
    t.bigint "book_id", null: false
    t.bigint "member_id"
    t.date "borrowed_date"
    t.date "due_date"
    t.date "returned_date"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_borrowings_on_book_id"
    t.index ["member_id"], name: "index_borrowings_on_member_id"
  end

  create_table "members", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.text "address"
    t.date "membership_date"
    t.string "membership_type"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "book_requests", "books"
  add_foreign_key "book_requests", "members"
  add_foreign_key "book_requests", "users", column: "approved_by_id"
  add_foreign_key "book_requests", "users", column: "requested_by_id"
  add_foreign_key "books", "authors"
  add_foreign_key "borrowings", "books"
  add_foreign_key "borrowings", "members"
end
