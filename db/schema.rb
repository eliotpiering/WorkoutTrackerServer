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

ActiveRecord::Schema.define(version: 2021_05_14_021501) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
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
    t.integer "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "exercises", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "lift_attempts", force: :cascade do |t|
    t.integer "lift_id", null: false
    t.integer "target_reps"
    t.integer "target_weight"
    t.integer "target_time"
    t.integer "reps"
    t.integer "weight"
    t.integer "time"
    t.integer "position"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["lift_id"], name: "index_lift_attempts_on_lift_id"
  end

  create_table "lifts", force: :cascade do |t|
    t.integer "exercise_id", null: false
    t.integer "superset_id", null: false
    t.integer "position"
    t.boolean "left_and_right", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["exercise_id"], name: "index_lifts_on_exercise_id"
    t.index ["superset_id"], name: "index_lifts_on_superset_id"
  end

  create_table "program_days", force: :cascade do |t|
    t.integer "program_id", null: false
    t.string "name"
    t.integer "position"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["program_id"], name: "index_program_days_on_program_id"
  end

  create_table "program_lifts", force: :cascade do |t|
    t.integer "program_superset_id", null: false
    t.integer "exercise_id"
    t.integer "position"
    t.json "weekly_lifts"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["exercise_id"], name: "index_program_lifts_on_exercise_id"
    t.index ["program_superset_id"], name: "index_program_lifts_on_program_superset_id"
  end

  create_table "program_supersets", force: :cascade do |t|
    t.integer "program_day_id", null: false
    t.string "name"
    t.integer "rest_period"
    t.integer "position"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["program_day_id"], name: "index_program_supersets_on_program_day_id"
  end

  create_table "programs", force: :cascade do |t|
    t.integer "weeks"
    t.integer "workouts_per_week"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "supersets", force: :cascade do |t|
    t.string "name"
    t.integer "workout_id", null: false
    t.integer "position"
    t.integer "rest_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["workout_id"], name: "index_supersets_on_workout_id"
  end

  create_table "workouts", force: :cascade do |t|
    t.string "name"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "lift_attempts", "lifts"
  add_foreign_key "lifts", "exercises"
  add_foreign_key "lifts", "supersets"
  add_foreign_key "program_days", "programs"
  add_foreign_key "program_lifts", "exercises"
  add_foreign_key "program_lifts", "program_supersets"
  add_foreign_key "program_supersets", "program_days"
  add_foreign_key "supersets", "workouts"
end
