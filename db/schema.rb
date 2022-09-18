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

ActiveRecord::Schema[7.0].define(version: 2022_09_18_115150) do
  create_table "assignment_case_steps", force: :cascade do |t|
    t.integer "assignment_id", null: false
    t.integer "case_id", null: false
    t.integer "step_id", null: false
    t.boolean "passed"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assignment_id"], name: "index_assignment_case_steps_on_assignment_id"
    t.index ["case_id"], name: "index_assignment_case_steps_on_case_id"
    t.index ["step_id"], name: "index_assignment_case_steps_on_step_id"
  end

  create_table "assignments", force: :cascade do |t|
    t.integer "run_id", null: false
    t.string "token"
    t.string "email"
    t.boolean "completed", default: false, null: false
    t.boolean "passed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["run_id"], name: "index_assignments_on_run_id"
  end

  create_table "case_runs", force: :cascade do |t|
    t.integer "case_id", null: false
    t.integer "run_id", null: false
    t.integer "row_order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["case_id"], name: "index_case_runs_on_case_id"
    t.index ["run_id"], name: "index_case_runs_on_run_id"
  end

  create_table "case_steps", force: :cascade do |t|
    t.integer "case_id", null: false
    t.integer "step_id", null: false
    t.integer "row_order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["case_id"], name: "index_case_steps_on_case_id"
    t.index ["step_id"], name: "index_case_steps_on_step_id"
  end

  create_table "cases", force: :cascade do |t|
    t.integer "suite_id", null: false
    t.string "title", null: false
    t.text "description"
    t.text "acceptance_criteria", null: false
    t.integer "steps_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["suite_id"], name: "index_cases_on_suite_id"
  end

  create_table "projects", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "title", null: false
    t.text "description"
    t.integer "steps_count", default: 0
    t.integer "suites_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "runs", force: :cascade do |t|
    t.integer "project_id", null: false
    t.string "title", null: false
    t.text "description"
    t.integer "case_runs_count", default: 0, null: false
    t.integer "assignments_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_runs_on_project_id"
  end

  create_table "steps", force: :cascade do |t|
    t.integer "project_id", null: false
    t.string "title", null: false
    t.text "description"
    t.text "acceptance_criteria", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_steps_on_project_id"
  end

  create_table "suites", force: :cascade do |t|
    t.integer "project_id", null: false
    t.string "title", null: false
    t.text "description"
    t.integer "cases_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_suites_on_project_id"
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

  add_foreign_key "assignment_case_steps", "assignments"
  add_foreign_key "assignment_case_steps", "cases"
  add_foreign_key "assignment_case_steps", "steps"
  add_foreign_key "assignments", "runs"
  add_foreign_key "case_runs", "cases"
  add_foreign_key "case_runs", "runs"
  add_foreign_key "case_steps", "cases"
  add_foreign_key "case_steps", "steps"
  add_foreign_key "cases", "suites"
  add_foreign_key "projects", "users"
  add_foreign_key "runs", "projects"
  add_foreign_key "steps", "projects"
  add_foreign_key "suites", "projects"
end
