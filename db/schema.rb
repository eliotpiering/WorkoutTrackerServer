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

ActiveRecord::Schema.define(version: 2021_03_16_024839) do

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

  add_foreign_key "lift_attempts", "lifts"
  add_foreign_key "lifts", "exercises"
  add_foreign_key "lifts", "supersets"
  add_foreign_key "supersets", "workouts"
end
