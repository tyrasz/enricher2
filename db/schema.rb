# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_04_11_141714) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "announcements", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "appointments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "office_hour_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.index ["office_hour_id"], name: "index_appointments_on_office_hour_id"
    t.index ["user_id"], name: "index_appointments_on_user_id"
  end

  create_table "classroom_announcements", force: :cascade do |t|
    t.bigint "classroom_id", null: false
    t.bigint "announcement_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["announcement_id"], name: "index_classroom_announcements_on_announcement_id"
    t.index ["classroom_id"], name: "index_classroom_announcements_on_classroom_id"
  end

  create_table "classrooms", force: :cascade do |t|
    t.string "name"
    t.boolean "is_active"
    t.string "academic_year"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_classrooms_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "content"
    t.bigint "ticket_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "author_id"
    t.index ["ticket_id"], name: "index_comments_on_ticket_id"
  end

  create_table "enrollments", force: :cascade do |t|
    t.bigint "student_id", null: false
    t.bigint "classroom_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["classroom_id"], name: "index_enrollments_on_classroom_id"
    t.index ["student_id"], name: "index_enrollments_on_student_id"
  end

  create_table "guardianships", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "student_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["student_id"], name: "index_guardianships_on_student_id"
    t.index ["user_id"], name: "index_guardianships_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "content"
    t.bigint "classroom_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["classroom_id"], name: "index_messages_on_classroom_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "office_hours", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.index ["user_id"], name: "index_office_hours_on_user_id"
  end

  create_table "students", force: :cascade do |t|
    t.boolean "is_active"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tickets", force: :cascade do |t|
    t.boolean "is_private", default: false
    t.string "status"
    t.string "question"
    t.bigint "user_id", null: false
    t.bigint "classroom_id", null: false
    t.string "category_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["classroom_id"], name: "index_tickets_on_classroom_id"
    t.index ["user_id"], name: "index_tickets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "role"
    t.boolean "is_active", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "nickname"
    t.string "name"
    t.boolean "admin", default: false
    t.string "authentication_token", limit: 30
    t.string "access_token"
    t.datetime "expires_at"
    t.string "refresh_token"
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "appointments", "office_hours"
  add_foreign_key "appointments", "users"
  add_foreign_key "classroom_announcements", "announcements"
  add_foreign_key "classroom_announcements", "classrooms"
  add_foreign_key "classrooms", "users"
  add_foreign_key "comments", "tickets"
  add_foreign_key "comments", "users", column: "author_id"
  add_foreign_key "enrollments", "classrooms"
  add_foreign_key "enrollments", "students"
  add_foreign_key "guardianships", "students"
  add_foreign_key "guardianships", "users"
  add_foreign_key "messages", "classrooms"
  add_foreign_key "messages", "users"
  add_foreign_key "office_hours", "users"
  add_foreign_key "tickets", "classrooms"
  add_foreign_key "tickets", "users"
end
