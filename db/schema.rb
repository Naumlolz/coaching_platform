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

ActiveRecord::Schema.define(version: 2021_04_30_095415) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.string "password", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "coaches", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.text "description"
    t.integer "age", null: false
    t.string "gender", null: false
    t.string "email", null: false
    t.string "password", null: false
    t.string "expertise", null: false
    t.string "education", null: false
    t.string "experience", null: false
    t.string "certificate", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "programs", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "techniques", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.bigint "program_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["program_id"], name: "index_techniques_on_program_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.integer "age", null: false
    t.text "description"
    t.string "gender", null: false
    t.string "email", null: false
    t.string "password", null: false
    t.bigint "coach_id"
    t.bigint "program_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["coach_id"], name: "index_users_on_coach_id"
    t.index ["program_id"], name: "index_users_on_program_id"
  end

  create_table "users_coaches_invitations", force: :cascade do |t|
    t.string "body", null: false
    t.boolean "accepted", default: false
    t.bigint "user_id"
    t.bigint "coach_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["coach_id"], name: "index_users_coaches_invitations_on_coach_id"
    t.index ["user_id"], name: "index_users_coaches_invitations_on_user_id"
  end

  create_table "users_techniques", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "technique_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["technique_id"], name: "index_users_techniques_on_technique_id"
    t.index ["user_id"], name: "index_users_techniques_on_user_id"
  end

  create_table "users_techniques_ratings", force: :cascade do |t|
    t.string "rate"
    t.bigint "user_id"
    t.bigint "technique_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["technique_id"], name: "index_users_techniques_ratings_on_technique_id"
    t.index ["user_id"], name: "index_users_techniques_ratings_on_user_id"
  end

  add_foreign_key "techniques", "programs"
  add_foreign_key "users", "coaches"
  add_foreign_key "users", "programs"
  add_foreign_key "users_coaches_invitations", "coaches"
  add_foreign_key "users_coaches_invitations", "users"
  add_foreign_key "users_techniques", "techniques"
  add_foreign_key "users_techniques", "users"
  add_foreign_key "users_techniques_ratings", "techniques"
  add_foreign_key "users_techniques_ratings", "users"
end
