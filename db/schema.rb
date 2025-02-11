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

ActiveRecord::Schema.define(version: 2025_02_11_092420) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

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
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "coaches", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.text "description"
    t.integer "age"
    t.string "gender"
    t.string "email", null: false
    t.string "password", null: false
    t.string "education"
    t.string "experience"
    t.string "certificate"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "total_users_count", default: 0
    t.index ["email"], name: "index_coaches_on_email", unique: true
  end

  create_table "coaches_programs", force: :cascade do |t|
    t.bigint "coach_id"
    t.bigint "program_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["coach_id"], name: "index_coaches_programs_on_coach_id"
    t.index ["program_id"], name: "index_coaches_programs_on_program_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "body"
    t.boolean "sent_by_coach", default: false
    t.bigint "user_id"
    t.bigint "coach_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["coach_id"], name: "index_messages_on_coach_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "programs", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "steps", force: :cascade do |t|
    t.string "title", null: false
    t.text "body"
    t.integer "position"
    t.bigint "technique_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["technique_id"], name: "index_steps_on_technique_id"
  end

  create_table "techniques", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.bigint "program_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["program_id"], name: "index_techniques_on_program_id"
  end

  create_table "user_completed_steps", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "step_id"
    t.bigint "technique_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.bigint "users_technique_id"
    t.index ["step_id"], name: "index_user_completed_steps_on_step_id"
    t.index ["technique_id"], name: "index_user_completed_steps_on_technique_id"
    t.index ["user_id"], name: "index_user_completed_steps_on_user_id"
    t.index ["users_technique_id"], name: "index_user_completed_steps_on_users_technique_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.integer "age"
    t.text "description"
    t.string "gender"
    t.string "email", null: false
    t.string "password", null: false
    t.bigint "coach_id"
    t.bigint "program_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reset_password_code"
    t.datetime "reset_password_code_sent_at"
    t.index ["coach_id"], name: "index_users_on_coach_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["program_id"], name: "index_users_on_program_id"
  end

  create_table "users_coaches_invitations", force: :cascade do |t|
    t.boolean "accepted"
    t.bigint "user_id"
    t.bigint "coach_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["coach_id"], name: "index_users_coaches_invitations_on_coach_id"
    t.index ["user_id"], name: "index_users_coaches_invitations_on_user_id"
  end

  create_table "users_programs_ratings", force: :cascade do |t|
    t.string "rating_type", null: false
    t.bigint "user_id", null: false
    t.bigint "program_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["program_id"], name: "index_users_programs_ratings_on_program_id"
    t.index ["user_id", "program_id"], name: "index_users_programs_ratings_on_user_id_and_program_id", unique: true
    t.index ["user_id"], name: "index_users_programs_ratings_on_user_id"
  end

  create_table "users_techniques", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "technique_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "technique_status"
    t.boolean "completed", default: false
    t.index ["technique_id"], name: "index_users_techniques_on_technique_id"
    t.index ["user_id", "technique_id"], name: "index_users_techniques_on_user_id_and_technique_id", unique: true
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

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "coaches_programs", "coaches"
  add_foreign_key "coaches_programs", "programs"
  add_foreign_key "messages", "coaches"
  add_foreign_key "messages", "users"
  add_foreign_key "steps", "techniques"
  add_foreign_key "techniques", "programs"
  add_foreign_key "user_completed_steps", "steps"
  add_foreign_key "user_completed_steps", "techniques"
  add_foreign_key "user_completed_steps", "users"
  add_foreign_key "user_completed_steps", "users_techniques"
  add_foreign_key "users", "coaches"
  add_foreign_key "users", "programs"
  add_foreign_key "users_coaches_invitations", "coaches"
  add_foreign_key "users_coaches_invitations", "users"
  add_foreign_key "users_programs_ratings", "programs"
  add_foreign_key "users_programs_ratings", "users"
  add_foreign_key "users_techniques", "techniques"
  add_foreign_key "users_techniques", "users"
  add_foreign_key "users_techniques_ratings", "techniques"
  add_foreign_key "users_techniques_ratings", "users"
end
