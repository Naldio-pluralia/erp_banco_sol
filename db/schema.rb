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

ActiveRecord::Schema.define(version: 20190211090250) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "absence_days", force: :cascade do |t|
    t.bigint "employee_absence_id"
    t.date "date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_absence_id"], name: "index_absence_days_on_employee_absence_id"
  end

  create_table "absence_types", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.integer "kind", default: 0, null: false
    t.integer "code", default: 0, null: false
    t.boolean "requires_document", default: false, null: false
    t.boolean "requires_justification", default: false, null: false
    t.boolean "requires_supervisor_justification", default: false, null: false
    t.boolean "requires_supervisor_supervisor_justification", default: false, null: false
    t.boolean "requires_approver_justification", default: false, null: false
    t.boolean "requires_approver_supervisor_justification", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_system_absence", default: false, null: false
  end

  create_table "admins", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.boolean "is_menu_minimized", default: false, null: false
    t.string "avatar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "middle_name"
    t.string "cellphone"
    t.string "permissions", default: [], array: true
    t.integer "roles_mask", default: -1, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "appliances", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "cellphone", null: false
    t.string "resume", null: false
    t.json "attachments"
    t.text "note", null: false
    t.integer "relevance", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "applications", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "cellphone"
    t.date "birthdate"
    t.integer "civil_status", default: 0, null: false
    t.integer "dependents_number", default: 0, null: false
    t.string "note"
    t.integer "status", default: 0, null: false
    t.integer "relevance", default: 0, null: false
    t.bigint "employee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "vacancy_id"
    t.index ["employee_id"], name: "index_applications_on_employee_id"
    t.index ["vacancy_id"], name: "index_applications_on_vacancy_id"
  end

  create_table "approvers", force: :cascade do |t|
    t.bigint "employee_id"
    t.integer "kind", default: 0, null: false
    t.bigint "absence_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["absence_type_id"], name: "index_approvers_on_absence_type_id"
    t.index ["employee_id"], name: "index_approvers_on_employee_id"
  end

  create_table "assessment_settings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chapters", force: :cascade do |t|
    t.integer "number", null: false
    t.string "name", null: false
    t.bigint "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_chapters_on_course_id"
  end

  create_table "christmas_subsidies", force: :cascade do |t|
    t.string "name", null: false
    t.string "abbr_name", null: false
    t.decimal "percentage", default: "0.0", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "christmas_subsidy_salaries", force: :cascade do |t|
    t.decimal "value", default: "0.0", null: false
    t.integer "year", null: false
    t.bigint "salary_id"
    t.bigint "christmas_subsidy_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["christmas_subsidy_id"], name: "index_christmas_subsidy_salaries_on_christmas_subsidy_id"
    t.index ["salary_id"], name: "index_christmas_subsidy_salaries_on_salary_id"
  end

  create_table "corporate_goals", force: :cascade do |t|
    t.bigint "general_goal_id"
    t.bigint "assessment_id"
    t.integer "period", default: 0, null: false
    t.text "objectives", default: "", null: false
    t.float "target", default: 0.0, null: false
    t.integer "mode", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assessment_id"], name: "index_corporate_goals_on_assessment_id"
    t.index ["general_goal_id"], name: "index_corporate_goals_on_general_goal_id"
  end

  create_table "corporate_goals_next_sgad_employees", id: false, force: :cascade do |t|
    t.bigint "corporate_goal_id", null: false
    t.bigint "next_sgad_employee_id", null: false
    t.index ["corporate_goal_id", "next_sgad_employee_id"], name: "idx_corporate_goals_employees_db"
  end

  create_table "corporate_goals_next_sgad_functions", id: false, force: :cascade do |t|
    t.bigint "corporate_goal_id", null: false
    t.bigint "next_sgad_function_id", null: false
    t.index ["corporate_goal_id", "next_sgad_function_id"], name: "idx_corporate_goals_functions_db"
  end

  create_table "corporate_goals_next_sgad_positions", id: false, force: :cascade do |t|
    t.bigint "corporate_goal_id", null: false
    t.bigint "next_sgad_position_id", null: false
    t.index ["corporate_goal_id", "next_sgad_position_id"], name: "idx_corporate_goals_positions_db"
  end

  create_table "course_obligated_functions", force: :cascade do |t|
    t.bigint "course_id"
    t.bigint "function_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_course_obligated_functions_on_course_id"
    t.index ["function_id"], name: "index_course_obligated_functions_on_function_id"
  end

  create_table "course_optional_functions", force: :cascade do |t|
    t.bigint "course_id"
    t.bigint "function_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_course_optional_functions_on_course_id"
    t.index ["function_id"], name: "index_course_optional_functions_on_function_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "name", null: false
    t.integer "status", default: 0, null: false
    t.boolean "for_all", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "approval_amount", default: 50, null: false
    t.text "description"
  end

  create_table "date_types", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.date "date", null: false
    t.integer "kind", default: 1, null: false
    t.boolean "recurrent", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "directorate_areas", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "directorates", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "directorate_area_id"
    t.string "abbreviation", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "pelouro_id"
    t.index ["directorate_area_id"], name: "index_directorates_on_directorate_area_id"
    t.index ["pelouro_id"], name: "index_directorates_on_pelouro_id"
  end

  create_table "employee_absences", force: :cascade do |t|
    t.bigint "employee_id"
    t.bigint "absence_type_id"
    t.date "returned_at", null: false
    t.date "left_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["absence_type_id"], name: "index_employee_absences_on_absence_type_id"
    t.index ["employee_id"], name: "index_employee_absences_on_employee_id"
  end

  create_table "employee_absences_justifications", id: false, force: :cascade do |t|
    t.bigint "employee_absence_id", null: false
    t.bigint "employee_justification_id", null: false
    t.index ["employee_absence_id", "employee_justification_id"], name: "idx_absences_justifications_on_absence_id_and_justification_id"
  end

  create_table "employee_answers", force: :cascade do |t|
    t.text "answer"
    t.boolean "option", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0, null: false
    t.bigint "employee_question_id"
    t.index ["employee_question_id"], name: "index_employee_answers_on_employee_question_id"
  end

  create_table "employee_avaliable_vacations", force: :cascade do |t|
    t.bigint "employee_id"
    t.integer "year", null: false
    t.integer "number_of_days", default: 0, null: false
    t.date "valid_from", null: false
    t.date "valid_until", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_employee_avaliable_vacations_on_employee_id"
  end

  create_table "employee_chapters", force: :cascade do |t|
    t.bigint "employee_course_id"
    t.bigint "chapter_id"
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chapter_id"], name: "index_employee_chapters_on_chapter_id"
    t.index ["employee_course_id"], name: "index_employee_chapters_on_employee_course_id"
  end

  create_table "employee_courses", force: :cascade do |t|
    t.bigint "employee_id"
    t.bigint "course_id"
    t.datetime "end"
    t.integer "status", default: 0, null: false
    t.integer "attempt_number", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "conclusion_percentage", default: "0.0", null: false
    t.boolean "is_approved", default: false, null: false
    t.decimal "value", default: "0.0", null: false
    t.index ["course_id"], name: "index_employee_courses_on_course_id"
    t.index ["employee_id"], name: "index_employee_courses_on_employee_id"
  end

  create_table "employee_delays", force: :cascade do |t|
    t.bigint "employee_id"
    t.bigint "absence_type_id"
    t.datetime "arrived_at", null: false
    t.integer "number_of_hours_late", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["absence_type_id"], name: "index_employee_delays_on_absence_type_id"
    t.index ["employee_id"], name: "index_employee_delays_on_employee_id"
  end

  create_table "employee_delays_justifications", id: false, force: :cascade do |t|
    t.bigint "employee_delay_id", null: false
    t.bigint "employee_justification_id", null: false
    t.index ["employee_delay_id", "employee_justification_id"], name: "idx_delays_justifications_on_delay_id_and_justification_id"
  end

  create_table "employee_exams", force: :cascade do |t|
    t.bigint "exam_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0, null: false
    t.bigint "employee_chapter_id"
    t.index ["employee_chapter_id"], name: "index_employee_exams_on_employee_chapter_id"
    t.index ["exam_id"], name: "index_employee_exams_on_exam_id"
  end

  create_table "employee_exits", force: :cascade do |t|
    t.bigint "employee_id"
    t.bigint "absence_type_id"
    t.integer "kind", default: 0, null: false
    t.date "date", null: false
    t.time "left_at", null: false
    t.time "returned_at", null: false
    t.integer "number_of_hours_absent", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["absence_type_id"], name: "index_employee_exits_on_absence_type_id"
    t.index ["employee_id"], name: "index_employee_exits_on_employee_id"
  end

  create_table "employee_exits_justifications", id: false, force: :cascade do |t|
    t.bigint "employee_exit_id", null: false
    t.bigint "employee_justification_id", null: false
    t.index ["employee_exit_id", "employee_justification_id"], name: "idx_exits_justifications_on_exit_id_and_justification_id"
  end

  create_table "employee_justifications", force: :cascade do |t|
    t.bigint "employee_id"
    t.json "attachments"
    t.text "employee_note"
    t.text "supervisor_note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "employee_absence_id"
    t.bigint "employee_delay_id"
    t.bigint "employee_exit_id"
    t.index ["employee_absence_id"], name: "index_employee_justifications_on_employee_absence_id"
    t.index ["employee_delay_id"], name: "index_employee_justifications_on_employee_delay_id"
    t.index ["employee_exit_id"], name: "index_employee_justifications_on_employee_exit_id"
    t.index ["employee_id"], name: "index_employee_justifications_on_employee_id"
  end

  create_table "employee_lessons", force: :cascade do |t|
    t.bigint "lesson_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0, null: false
    t.bigint "employee_chapter_id"
    t.index ["employee_chapter_id"], name: "index_employee_lessons_on_employee_chapter_id"
    t.index ["lesson_id"], name: "index_employee_lessons_on_lesson_id"
  end

  create_table "employee_paygrades", force: :cascade do |t|
    t.integer "level", default: 0, null: false
    t.integer "paygrade", null: false
    t.date "since", null: false
    t.date "until"
    t.bigint "employee_id"
    t.bigint "paygrade_change_reason_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "base_salary", default: "0.0", null: false
    t.index ["employee_id"], name: "index_employee_paygrades_on_employee_id"
    t.index ["paygrade_change_reason_id"], name: "index_employee_paygrades_on_paygrade_change_reason_id"
  end

  create_table "employee_presences", force: :cascade do |t|
    t.bigint "employee_id"
    t.date "date", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_employee_presences_on_employee_id"
  end

  create_table "employee_question_options", force: :cascade do |t|
    t.bigint "question_option_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "employee_question_id"
    t.boolean "is_selected", default: false, null: false
    t.index ["employee_question_id"], name: "index_employee_question_options_on_employee_question_id"
    t.index ["question_option_id"], name: "index_employee_question_options_on_question_option_id"
  end

  create_table "employee_questions", force: :cascade do |t|
    t.bigint "employee_exam_id"
    t.bigint "question_id"
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_exam_id"], name: "index_employee_questions_on_employee_exam_id"
    t.index ["question_id"], name: "index_employee_questions_on_question_id"
  end

  create_table "employee_regimes", force: :cascade do |t|
    t.integer "regime", default: 0, null: false
    t.time "enters_at"
    t.time "leaves_at"
    t.bigint "employee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_employee_regimes_on_employee_id"
  end

  create_table "employee_requests", force: :cascade do |t|
    t.bigint "employee_id"
    t.string "name", null: false
    t.text "note"
    t.bigint "request_type_id"
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "virtual_object_attachments", default: {}
    t.index ["employee_id"], name: "index_employee_requests_on_employee_id"
    t.index ["request_type_id"], name: "index_employee_requests_on_request_type_id"
  end

  create_table "employee_salary_families", force: :cascade do |t|
    t.bigint "employee_id"
    t.bigint "salary_family_id"
    t.bigint "paygrade_change_reason_id"
    t.string "level", null: false
    t.integer "paygrade", null: false
    t.date "since", null: false
    t.decimal "base_salary", default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_employee_salary_families_on_employee_id"
    t.index ["paygrade_change_reason_id"], name: "index_employee_salary_families_on_paygrade_change_reason_id"
    t.index ["salary_family_id"], name: "index_employee_salary_families_on_salary_family_id"
  end

  create_table "employee_skills", force: :cascade do |t|
    t.bigint "skill_id"
    t.bigint "employee_id"
    t.decimal "value", default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "self_assessment", default: "0.0", null: false
    t.decimal "supervisor_assessment", default: "0.0", null: false
    t.index ["employee_id"], name: "index_employee_skills_on_employee_id"
    t.index ["skill_id"], name: "index_employee_skills_on_skill_id"
  end

  create_table "employee_vacation_responses", force: :cascade do |t|
    t.bigint "employee_vacation_id"
    t.bigint "employee_id"
    t.integer "status", default: 0, null: false
    t.integer "kind", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_employee_vacation_responses_on_employee_id"
    t.index ["employee_vacation_id"], name: "index_employee_vacation_responses_on_employee_vacation_id"
  end

  create_table "employee_vacations", force: :cascade do |t|
    t.bigint "employee_id"
    t.date "left_at", null: false
    t.date "returned_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_employee_vacations_on_employee_id"
  end

  create_table "employee_work_periods", force: :cascade do |t|
    t.date "since", null: false
    t.date "until"
    t.bigint "employee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_employee_work_periods_on_employee_id"
  end

  create_table "establishment_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "establishments", force: :cascade do |t|
    t.bigint "establishment_type_id"
    t.bigint "municipality_id"
    t.string "name"
    t.string "code"
    t.string "abbreviation"
    t.date "inaugurated_at"
    t.integer "atm_count"
    t.integer "tpa_count"
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "establishment_id"
    t.bigint "position_id"
    t.index ["establishment_id"], name: "index_establishments_on_establishment_id"
    t.index ["establishment_type_id"], name: "index_establishments_on_establishment_type_id"
    t.index ["municipality_id"], name: "index_establishments_on_municipality_id"
    t.index ["position_id"], name: "index_establishments_on_position_id"
  end

  create_table "exams", force: :cascade do |t|
    t.bigint "chapter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chapter_id"], name: "index_exams_on_chapter_id"
  end

  create_table "function_areas", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "function_areas_next_sgad_functions", id: false, force: :cascade do |t|
    t.bigint "function_area_id", null: false
    t.bigint "next_sgad_function_id", null: false
    t.index ["function_area_id", "next_sgad_function_id"], name: "ndx_fnctn_rs_fnctns_n_fnctn_r_d_and_fnctn_d"
  end

  create_table "function_autonomy_levels", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "function_autonomy_levels_next_sgad_functions", id: false, force: :cascade do |t|
    t.bigint "function_autonomy_level_id", null: false
    t.bigint "next_sgad_function_id", null: false
    t.index ["function_autonomy_level_id", "next_sgad_function_id"], name: "idx_tnmy_lvls_n_fnctn_my_lvl_d_nd_fnctn_d"
  end

  create_table "function_contract_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "function_deslocation_regimes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "function_settings", force: :cascade do |t|
    t.integer "max_chairman_number", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "maximum_objective_number", default: 0, null: false
  end

  create_table "function_skills", force: :cascade do |t|
    t.decimal "min", default: "0.0", null: false
    t.decimal "recomended", default: "5.0", null: false
    t.bigint "skill_id"
    t.bigint "function_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["function_id"], name: "index_function_skills_on_function_id"
    t.index ["skill_id"], name: "index_function_skills_on_skill_id"
  end

  create_table "function_subsidies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "function_subsidies_next_sgad_functions", id: false, force: :cascade do |t|
    t.bigint "function_subsidy_id", null: false
    t.bigint "next_sgad_function_id", null: false
    t.index ["function_subsidy_id", "next_sgad_function_id"], name: "ndx_fnctn_rs_fnctns_n_fnctn_r_d_nd_fnctn_d"
  end

  create_table "general_goals", force: :cascade do |t|
    t.integer "period", default: 0, null: false
    t.text "objectives", default: "", null: false
    t.float "target", default: 0.0, null: false
    t.integer "mode", default: 0, null: false
    t.bigint "assessment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assessment_id"], name: "index_general_goals_on_assessment_id"
  end

  create_table "general_goals_next_sgad_employees", id: false, force: :cascade do |t|
    t.bigint "general_goal_id", null: false
    t.bigint "next_sgad_employee_id", null: false
    t.index ["general_goal_id", "next_sgad_employee_id"], name: "idx_general_goals_employees_db"
  end

  create_table "general_goals_next_sgad_functions", id: false, force: :cascade do |t|
    t.bigint "general_goal_id", null: false
    t.bigint "next_sgad_function_id", null: false
    t.index ["general_goal_id", "next_sgad_function_id"], name: "idx_general_goals_functions_db"
  end

  create_table "general_goals_next_sgad_positions", id: false, force: :cascade do |t|
    t.bigint "general_goal_id", null: false
    t.bigint "next_sgad_position_id", null: false
    t.index ["general_goal_id", "next_sgad_position_id"], name: "idx_general_goals_positions_db"
  end

  create_table "groups", force: :cascade do |t|
    t.integer "status", default: 0, null: false
    t.integer "group_type", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups_next_sgad_employees", id: false, force: :cascade do |t|
    t.bigint "group_id", null: false
    t.bigint "next_sgad_employee_id", null: false
    t.index ["group_id", "next_sgad_employee_id"], name: "index_employees_groups_on_group_id_and_employee_id"
  end

  create_table "groups_next_sgad_functions", id: false, force: :cascade do |t|
    t.bigint "group_id", null: false
    t.bigint "next_sgad_function_id", null: false
    t.index ["group_id", "next_sgad_function_id"], name: "index_functions_groups_on_group_id_and_function_id"
  end

  create_table "groups_next_sgad_positions", id: false, force: :cascade do |t|
    t.bigint "group_id", null: false
    t.bigint "next_sgad_position_id", null: false
    t.index ["group_id", "next_sgad_position_id"], name: "index_positions_groups_on_group_id_and_position_id"
  end

  create_table "individual_goals", force: :cascade do |t|
    t.bigint "employee_id"
    t.decimal "individual_value", default: "0.0"
    t.decimal "supervisor_value", default: "0.0"
    t.decimal "pca_value", default: "0.0"
    t.string "pertence_type"
    t.bigint "pertence_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_individual_goals_on_employee_id"
    t.index ["pertence_type", "pertence_id"], name: "index_individual_goals_on_pertence_type_and_pertence_id"
  end

  create_table "justification_answers", force: :cascade do |t|
    t.bigint "employee_justification_id"
    t.bigint "employee_id"
    t.integer "status", default: 0, null: false
    t.integer "kind", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_justification_answers_on_employee_id"
    t.index ["employee_justification_id"], name: "index_justification_answers_on_employee_justification_id"
  end

  create_table "lessons", force: :cascade do |t|
    t.string "number", default: "1", null: false
    t.string "name", null: false
    t.string "video"
    t.text "text", null: false
    t.bigint "chapter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "local_video"
    t.integer "video_kind", default: 0, null: false
    t.index ["chapter_id"], name: "index_lessons_on_chapter_id"
  end

  create_table "municipalities", force: :cascade do |t|
    t.string "name"
    t.bigint "province_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["province_id"], name: "index_municipalities_on_province_id"
  end

  create_table "next_sgad_activities", force: :cascade do |t|
    t.string "created_by", default: "", null: false
    t.string "description", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "next_sgad_assessments", force: :cascade do |t|
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "year", null: false
    t.decimal "skills_percentage", default: "0.0", null: false
    t.decimal "objectives_percentage", default: "0.0", null: false
    t.decimal "attendance_percentage", default: "0.0", null: false
    t.integer "number_of_four_hours_delay_to_absence", default: 0, null: false
    t.integer "number_of_three_hours_delay_to_absence", default: 0, null: false
    t.integer "number_of_two_hours_delay_to_absence", default: 0, null: false
    t.integer "number_of_one_hour_delay_to_absence", default: 0, null: false
    t.integer "max_absences_for_five", default: 0, null: false
    t.integer "max_absences_for_four", default: 0, null: false
    t.integer "max_absences_for_three", default: 0, null: false
    t.integer "max_absences_for_two", default: 0, null: false
    t.integer "max_absences_for_one", default: 0, null: false
  end

  create_table "next_sgad_attendances", force: :cascade do |t|
    t.datetime "date"
    t.integer "status", null: false
    t.text "employee_note"
    t.text "supervisor_note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "assessment_id"
    t.bigint "position_id"
    t.bigint "employee_id"
    t.bigint "department_id"
    t.integer "justification_status", default: -1, null: false
    t.index ["assessment_id"], name: "index_next_sgad_attendances_on_assessment_id"
    t.index ["department_id"], name: "index_next_sgad_attendances_on_department_id"
    t.index ["employee_id"], name: "index_next_sgad_attendances_on_employee_id"
    t.index ["position_id"], name: "index_next_sgad_attendances_on_position_id"
  end

  create_table "next_sgad_attendances_justifications", id: false, force: :cascade do |t|
    t.bigint "next_sgad_attendance_id", null: false
    t.bigint "next_sgad_justification_id", null: false
    t.index ["next_sgad_attendance_id", "next_sgad_justification_id"], name: "indx_nxt_sgd_tndncs_jstns_on_attendence_id_and_justification_id"
  end

  create_table "next_sgad_departments", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "next_sgad_department_id"
    t.bigint "department_id"
    t.bigint "employee_id"
    t.index ["department_id"], name: "index_next_sgad_departments_on_department_id"
    t.index ["employee_id"], name: "index_next_sgad_departments_on_employee_id"
    t.index ["next_sgad_department_id"], name: "index_next_sgad_departments_on_next_sgad_department_id"
  end

  create_table "next_sgad_departments_messages", id: false, force: :cascade do |t|
    t.bigint "next_sgad_message_id", null: false
    t.bigint "next_sgad_department_id", null: false
    t.index ["next_sgad_message_id", "next_sgad_department_id"], name: "idx_nt_sd_depents_meges_on_sgad_message_id_and_sgad_depent_id"
  end

  create_table "next_sgad_employee_goal_activities", force: :cascade do |t|
    t.text "description"
    t.bigint "employee_goal_id"
    t.string "creator_type"
    t.bigint "creator_id"
    t.string "attachment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_type", "creator_id"], name: "index_employee_goal_activities_on_creator_type_and_creator_id"
    t.index ["employee_goal_id"], name: "index_next_sgad_employee_goal_activities_on_employee_goal_id"
  end

  create_table "next_sgad_employee_goals", force: :cascade do |t|
    t.decimal "self_assessment", default: "0.0", null: false
    t.decimal "supervisor_assessment", default: "0.0", null: false
    t.decimal "final_assessment", default: "0.0", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "assessment_id"
    t.bigint "goal_id"
    t.bigint "employee_id"
    t.integer "unit", default: 0, null: false
    t.integer "goal_type", default: 0, null: false
    t.integer "nature", default: 0, null: false
    t.float "target", default: 0.0, null: false
    t.string "name"
    t.text "description"
    t.bigint "position_id"
    t.text "employee_note"
    t.text "supervisor_note"
    t.decimal "amount", default: "0.0", null: false
    t.text "supervisor_supervisor_note"
    t.boolean "report", default: false, null: false
    t.index ["assessment_id"], name: "index_next_sgad_employee_goals_on_assessment_id"
    t.index ["employee_id"], name: "index_next_sgad_employee_goals_on_employee_id"
    t.index ["goal_id"], name: "index_next_sgad_employee_goals_on_goal_id"
    t.index ["position_id"], name: "index_next_sgad_employee_goals_on_position_id"
  end

  create_table "next_sgad_employee_messages", force: :cascade do |t|
    t.bigint "message_id"
    t.bigint "employee_id"
    t.integer "status", default: 0, null: false
    t.string "title"
    t.text "body"
    t.string "signature"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "read_at"
    t.index ["employee_id"], name: "index_next_sgad_employee_messages_on_employee_id"
    t.index ["message_id"], name: "index_next_sgad_employee_messages_on_message_id"
  end

  create_table "next_sgad_employees", force: :cascade do |t|
    t.string "number"
    t.integer "paygrade"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "level"
    t.string "avatar"
    t.string "first_name"
    t.string "last_name"
    t.string "middle_name"
    t.boolean "can_approve_justifications", default: false, null: false
    t.boolean "can_be_assessed", default: true, null: false
    t.integer "tolerance", default: 0, null: false
    t.integer "status", default: 0, null: false
  end

  create_table "next_sgad_employees_assessments", force: :cascade do |t|
    t.integer "self_assessment_status"
    t.integer "supervisor_assessment_status"
    t.integer "final_assessment_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "employee_id"
    t.bigint "assessment_id"
    t.decimal "result", default: "0.0", null: false
    t.boolean "manual", default: false, null: false
    t.decimal "self_result", default: "0.0", null: false
    t.decimal "supervisor_result", default: "0.0", null: false
    t.index ["assessment_id"], name: "index_next_sgad_employees_assessments_on_assessment_id"
    t.index ["employee_id"], name: "index_next_sgad_employees_assessments_on_employee_id"
  end

  create_table "next_sgad_employees_messages", id: false, force: :cascade do |t|
    t.bigint "next_sgad_message_id", null: false
    t.bigint "next_sgad_employee_id", null: false
    t.index ["next_sgad_message_id", "next_sgad_employee_id"], name: "index_sgad_eoyees_messages_on_sgad_mage_id_and_sgad_eoyee_id"
  end

  create_table "next_sgad_employees_positions", id: false, force: :cascade do |t|
    t.bigint "next_sgad_employee_id", null: false
    t.bigint "next_sgad_position_id", null: false
    t.index ["next_sgad_employee_id", "next_sgad_position_id"], name: "idx_nxt_sgad_employees_positions_on_employee_id_and_position_id"
  end

  create_table "next_sgad_employees_subsidy_types", id: false, force: :cascade do |t|
    t.bigint "subsidy_type_id", null: false
    t.bigint "next_sgad_employee_id", null: false
    t.index ["subsidy_type_id", "next_sgad_employee_id"], name: "index_employee_tax_types_on_subsidy_type_id_and_employee_id"
  end

  create_table "next_sgad_employees_tax_types", id: false, force: :cascade do |t|
    t.bigint "tax_type_id", null: false
    t.bigint "next_sgad_employee_id", null: false
    t.index ["tax_type_id", "next_sgad_employee_id"], name: "index_employee_tax_types_on_tax_type_id_and_employee_id"
  end

  create_table "next_sgad_employees_team_goals", id: false, force: :cascade do |t|
    t.bigint "team_goal_id", null: false
    t.bigint "next_sgad_employee_id", null: false
    t.index ["team_goal_id", "next_sgad_employee_id"], name: "idx_team_goals_employees_db"
  end

  create_table "next_sgad_functions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.string "number"
    t.time "enters_at"
    t.time "leaves_at"
    t.integer "qualification_kind", default: 0, null: false
    t.text "objectives"
    t.text "other_requirements"
    t.bigint "function_contract_type_id"
    t.bigint "function_deslocation_regime_id"
    t.integer "experience_kind", default: 0, null: false
    t.integer "experience_years", default: 0, null: false
    t.bigint "directorate_id"
    t.bigint "organic_unit_id"
    t.index ["directorate_id"], name: "index_next_sgad_functions_on_directorate_id"
    t.index ["function_contract_type_id"], name: "index_next_sgad_functions_on_function_contract_type_id"
    t.index ["function_deslocation_regime_id"], name: "index_next_sgad_functions_on_function_deslocation_regime_id"
    t.index ["organic_unit_id"], name: "index_next_sgad_functions_on_organic_unit_id"
  end

  create_table "next_sgad_functions_goals", id: false, force: :cascade do |t|
    t.bigint "next_sgad_goal_id", null: false
    t.bigint "next_sgad_function_id", null: false
    t.index ["next_sgad_goal_id", "next_sgad_function_id"], name: "idx_nxt_sgd_fctns_gls_n_nxt_sgd_goal_id_and_nt_sgd_function_id"
  end

  create_table "next_sgad_functions_messages", id: false, force: :cascade do |t|
    t.bigint "next_sgad_message_id", null: false
    t.bigint "next_sgad_function_id", null: false
    t.index ["next_sgad_message_id", "next_sgad_function_id"], name: "idx_sgad_funions_mesges_on_sgad_mesge_id_and_sgad_funion_id"
  end

  create_table "next_sgad_functions_subsidy_types", id: false, force: :cascade do |t|
    t.bigint "subsidy_type_id", null: false
    t.bigint "next_sgad_function_id", null: false
    t.index ["subsidy_type_id", "next_sgad_function_id"], name: "indx_funcns_suby_types_on_subsidy_type_id_and_function_id"
  end

  create_table "next_sgad_functions_tax_types", id: false, force: :cascade do |t|
    t.bigint "tax_type_id", null: false
    t.bigint "next_sgad_function_id", null: false
    t.index ["tax_type_id", "next_sgad_function_id"], name: "index_functions_tax_types_on_tax_type_id_and_function_id"
  end

  create_table "next_sgad_functions_team_goals", id: false, force: :cascade do |t|
    t.bigint "team_goal_id", null: false
    t.bigint "next_sgad_function_id", null: false
    t.index ["team_goal_id", "next_sgad_function_id"], name: "idx_teame_goals_functions_db"
  end

  create_table "next_sgad_goal_units", force: :cascade do |t|
    t.string "singular_name", null: false
    t.string "plural_name", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "next_sgad_goals", force: :cascade do |t|
    t.string "name"
    t.integer "goal_type", default: 0, null: false
    t.integer "status", default: 0, null: false
    t.integer "nature", default: 0, null: false
    t.integer "unit", default: 0, null: false
    t.float "target", default: 0.0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "assessment_id"
    t.text "description"
    t.boolean "for_everyone", default: false, null: false
    t.integer "period", default: 0, null: false
    t.bigint "goal_unit_id"
    t.index ["assessment_id"], name: "index_next_sgad_goals_on_assessment_id"
    t.index ["goal_unit_id"], name: "index_next_sgad_goals_on_goal_unit_id"
  end

  create_table "next_sgad_goals_positions", id: false, force: :cascade do |t|
    t.bigint "next_sgad_position_id", null: false
    t.bigint "next_sgad_goal_id", null: false
    t.index ["next_sgad_position_id", "next_sgad_goal_id"], name: "index_next_sgad_goals_positions_on_position_id_and_goal_id"
  end

  create_table "next_sgad_justifications", force: :cascade do |t|
    t.json "documents"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "employee_id"
    t.integer "status", default: 0, null: false
    t.text "employee_note"
    t.text "supervisor_note"
    t.integer "first_approval_status", default: 0, null: false
    t.integer "second_approval_status", default: 0, null: false
    t.index ["employee_id"], name: "index_next_sgad_justifications_on_employee_id"
  end

  create_table "next_sgad_messages", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.string "signature"
    t.boolean "send_to_all", default: false, null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "next_sgad_messages_positions", id: false, force: :cascade do |t|
    t.bigint "next_sgad_message_id", null: false
    t.bigint "next_sgad_position_id", null: false
    t.index ["next_sgad_message_id", "next_sgad_position_id"], name: "index_sgad_mees_poions_on_sgad_mege_id_and_sgad_poion_id"
  end

  create_table "next_sgad_positions", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "position_id"
    t.bigint "department_id"
    t.bigint "function_id"
    t.bigint "efective_id"
    t.bigint "organic_unit_id"
    t.bigint "establishment_id"
    t.index ["department_id"], name: "index_next_sgad_positions_on_department_id"
    t.index ["efective_id"], name: "index_next_sgad_positions_on_efective_id"
    t.index ["establishment_id"], name: "index_next_sgad_positions_on_establishment_id"
    t.index ["function_id"], name: "index_next_sgad_positions_on_function_id"
    t.index ["organic_unit_id"], name: "index_next_sgad_positions_on_organic_unit_id"
    t.index ["position_id"], name: "index_next_sgad_positions_on_position_id"
  end

  create_table "next_sgad_positions_subsidy_types", id: false, force: :cascade do |t|
    t.bigint "subsidy_type_id", null: false
    t.bigint "next_sgad_position_id", null: false
    t.index ["subsidy_type_id", "next_sgad_position_id"], name: "index_positns_subsidy_types_on_subsidy_type_id_and_position_id"
  end

  create_table "next_sgad_positions_tax_types", id: false, force: :cascade do |t|
    t.bigint "tax_type_id", null: false
    t.bigint "next_sgad_position_id", null: false
    t.index ["tax_type_id", "next_sgad_position_id"], name: "index_positions_tax_types_on_tax_type_id_and_position_id"
  end

  create_table "next_sgad_positions_team_goals", id: false, force: :cascade do |t|
    t.bigint "team_goal_id", null: false
    t.bigint "next_sgad_position_id", null: false
    t.index ["team_goal_id", "next_sgad_position_id"], name: "idx_team_goals_positions_db"
  end

  create_table "next_sgad_results", force: :cascade do |t|
    t.text "note"
    t.string "attachment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "employee_goal_id"
    t.decimal "result_value", default: "0.0", null: false
    t.integer "status", default: 0, null: false
    t.index ["employee_goal_id"], name: "index_next_sgad_results_on_employee_goal_id"
  end

  create_table "next_sgad_settings", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "version"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.string "description"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications_employee", force: :cascade do |t|
    t.integer "status", default: 0, null: false
    t.string "url"
    t.bigint "notification_id"
    t.bigint "employee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_notifications_employee_on_employee_id"
    t.index ["notification_id"], name: "index_notifications_employee_on_notification_id"
  end

  create_table "object_activities", force: :cascade do |t|
    t.text "description"
    t.string "object_type"
    t.bigint "object_id"
    t.string "creator_type"
    t.bigint "creator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_type", "creator_id"], name: "index_object_activities_on_creator_type_and_creator_id"
    t.index ["object_type", "object_id"], name: "index_object_activities_on_object_type_and_object_id"
  end

  create_table "object_approvers", force: :cascade do |t|
    t.bigint "employee_id"
    t.integer "kind", default: 0, null: false
    t.string "object_type"
    t.bigint "object_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_object_approvers_on_employee_id"
    t.index ["object_type", "object_id"], name: "index_object_approvers_on_object_type_and_object_id"
  end

  create_table "object_attachments", force: :cascade do |t|
    t.string "file", null: false
    t.string "description", null: false
    t.string "extension_whitelist", default: [], null: false, array: true
    t.string "object_type"
    t.bigint "object_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["object_type", "object_id"], name: "index_object_attachments_on_object_type_and_object_id"
  end

  create_table "object_responses", force: :cascade do |t|
    t.bigint "employee_id"
    t.string "object_type"
    t.bigint "object_id"
    t.integer "status", default: 0, null: false
    t.integer "kind", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_object_responses_on_employee_id"
    t.index ["object_type", "object_id"], name: "index_object_responses_on_object_type_and_object_id"
  end

  create_table "object_videos", force: :cascade do |t|
    t.string "local_title"
    t.string "local_file"
    t.string "local_file_tmp"
    t.boolean "local_file_processing"
    t.string "local_watermark_image"
    t.string "youtube_video_id"
    t.string "object_type"
    t.bigint "object_id"
    t.integer "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["object_type", "object_id"], name: "index_object_videos_on_object_type_and_object_id"
  end

  create_table "organic_unit_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "organic_units", force: :cascade do |t|
    t.bigint "organic_unit_type_id"
    t.string "name"
    t.string "abbreviation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "organic_unit_id"
    t.bigint "pelouro_id"
    t.index ["organic_unit_id"], name: "index_organic_units_on_organic_unit_id"
    t.index ["organic_unit_type_id"], name: "index_organic_units_on_organic_unit_type_id"
    t.index ["pelouro_id"], name: "index_organic_units_on_pelouro_id"
  end

  create_table "paygrade_boards", force: :cascade do |t|
    t.decimal "level_1_value", default: "0.0", null: false
    t.decimal "level_1_increment", default: "0.0", null: false
    t.decimal "level_1_a_value", default: "0.0", null: false
    t.decimal "level_1_b_value", default: "0.0", null: false
    t.decimal "level_1_c_value", default: "0.0", null: false
    t.decimal "level_1_d_value", default: "0.0", null: false
    t.decimal "level_2_value", default: "0.0", null: false
    t.decimal "level_2_increment", default: "0.0", null: false
    t.decimal "level_2_a_value", default: "0.0", null: false
    t.decimal "level_2_b_value", default: "0.0", null: false
    t.decimal "level_2_c_value", default: "0.0", null: false
    t.decimal "level_2_d_value", default: "0.0", null: false
    t.decimal "level_3_value", default: "0.0", null: false
    t.decimal "level_3_increment", default: "0.0", null: false
    t.decimal "level_3_a_value", default: "0.0", null: false
    t.decimal "level_3_b_value", default: "0.0", null: false
    t.decimal "level_3_c_value", default: "0.0", null: false
    t.decimal "level_3_d_value", default: "0.0", null: false
    t.decimal "level_4_value", default: "0.0", null: false
    t.decimal "level_4_increment", default: "0.0", null: false
    t.decimal "level_4_a_value", default: "0.0", null: false
    t.decimal "level_4_b_value", default: "0.0", null: false
    t.decimal "level_4_c_value", default: "0.0", null: false
    t.decimal "level_4_d_value", default: "0.0", null: false
    t.decimal "level_5_value", default: "0.0", null: false
    t.decimal "level_5_increment", default: "0.0", null: false
    t.decimal "level_5_a_value", default: "0.0", null: false
    t.decimal "level_5_b_value", default: "0.0", null: false
    t.decimal "level_5_c_value", default: "0.0", null: false
    t.decimal "level_5_d_value", default: "0.0", null: false
    t.decimal "level_6_value", default: "0.0", null: false
    t.decimal "level_6_increment", default: "0.0", null: false
    t.decimal "level_6_a_value", default: "0.0", null: false
    t.decimal "level_6_b_value", default: "0.0", null: false
    t.decimal "level_6_c_value", default: "0.0", null: false
    t.decimal "level_6_d_value", default: "0.0", null: false
    t.decimal "level_7_value", default: "0.0", null: false
    t.decimal "level_7_increment", default: "0.0", null: false
    t.decimal "level_7_a_value", default: "0.0", null: false
    t.decimal "level_7_b_value", default: "0.0", null: false
    t.decimal "level_7_c_value", default: "0.0", null: false
    t.decimal "level_7_d_value", default: "0.0", null: false
    t.decimal "level_8_value", default: "0.0", null: false
    t.decimal "level_8_increment", default: "0.0", null: false
    t.decimal "level_8_a_value", default: "0.0", null: false
    t.decimal "level_8_b_value", default: "0.0", null: false
    t.decimal "level_8_c_value", default: "0.0", null: false
    t.decimal "level_8_d_value", default: "0.0", null: false
    t.decimal "level_9_value", default: "0.0", null: false
    t.decimal "level_9_increment", default: "0.0", null: false
    t.decimal "level_9_a_value", default: "0.0", null: false
    t.decimal "level_9_b_value", default: "0.0", null: false
    t.decimal "level_9_c_value", default: "0.0", null: false
    t.decimal "level_9_d_value", default: "0.0", null: false
    t.decimal "level_10_value", default: "0.0", null: false
    t.decimal "level_10_increment", default: "0.0", null: false
    t.decimal "level_10_a_value", default: "0.0", null: false
    t.decimal "level_10_b_value", default: "0.0", null: false
    t.decimal "level_10_c_value", default: "0.0", null: false
    t.decimal "level_10_d_value", default: "0.0", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "paygrade_change_reasons", force: :cascade do |t|
    t.string "reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pelouros", force: :cascade do |t|
    t.string "name", null: false
    t.string "abbreviation"
    t.bigint "employee_id"
    t.string "title"
    t.string "title_abbreviation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_chairman", default: false, null: false
    t.index ["employee_id"], name: "index_pelouros_on_employee_id"
  end

  create_table "photos", force: :cascade do |t|
    t.text "image_data"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "plugins", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.boolean "is_active", default: true, null: false
    t.string "version"
    t.integer "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "url"
    t.integer "order", default: 100, null: false
    t.string "if_can"
    t.string "icon", default: "folder_at_mtl", null: false
  end

  create_table "provinces", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "question_options", force: :cascade do |t|
    t.bigint "question_id"
    t.integer "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "option", null: false
    t.index ["question_id"], name: "index_question_options_on_question_id"
  end

  create_table "questions", force: :cascade do |t|
    t.integer "number", null: false
    t.text "description", null: false
    t.integer "kind", null: false
    t.decimal "value", null: false
    t.boolean "boolean_option", default: true, null: false
    t.bigint "exam_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exam_id"], name: "index_questions_on_exam_id"
  end

  create_table "regime_for_all_employees", force: :cascade do |t|
  end

  create_table "remuneration_settings", force: :cascade do |t|
    t.decimal "base_salary", default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "day_to_process_salaries", default: 28, null: false
    t.integer "month_to_process_christmas_subsidy", default: 11, null: false
    t.decimal "update_factor", default: "15.0", null: false
  end

  create_table "report_reviewers", force: :cascade do |t|
    t.bigint "employee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_report_reviewers_on_employee_id"
  end

  create_table "reports", force: :cascade do |t|
    t.bigint "employee_id"
    t.string "name", null: false
    t.text "note", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_anonymous", default: false, null: false
    t.integer "status", default: 0, null: false
    t.index ["employee_id"], name: "index_reports_on_employee_id"
  end

  create_table "request_types", force: :cascade do |t|
    t.string "name", null: false
    t.text "note", null: false
    t.integer "code", default: 0, null: false
    t.integer "status", default: 0, null: false
    t.boolean "requires_supervisor_approval", default: true, null: false
    t.boolean "requires_supervisor_supervisor_approval", default: false, null: false
    t.boolean "requires_dpe_approval", default: false, null: false
    t.boolean "requires_dpe_supervisor_approval", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "virtual_object_attachments", default: {}
  end

  create_table "roles", force: :cascade do |t|
    t.string "account_type"
    t.bigint "account_id"
    t.integer "roles_mask", default: -1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "permissions", default: [], array: true
    t.index ["account_type", "account_id"], name: "index_roles_on_account_type_and_account_id"
  end

  create_table "salaries", force: :cascade do |t|
    t.decimal "base_value", default: "0.0", null: false
    t.decimal "value", default: "0.0", null: false
    t.decimal "status", default: "0.0", null: false
    t.date "period", null: false
    t.bigint "employee_paygrade_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "employee_salary_family_id"
    t.index ["employee_paygrade_id"], name: "index_salaries_on_employee_paygrade_id"
    t.index ["employee_salary_family_id"], name: "index_salaries_on_employee_salary_family_id"
  end

  create_table "salary_areas", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "salary_board_items", force: :cascade do |t|
    t.integer "paygrade", default: 1, null: false
    t.decimal "base_value", default: "0.0", null: false
    t.decimal "increment_value", default: "0.0", null: false
    t.decimal "a_value", default: "0.0", null: false
    t.decimal "b_value", default: "0.0", null: false
    t.decimal "c_value", default: "0.0", null: false
    t.decimal "d_value", default: "0.0", null: false
    t.bigint "salary_board_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["salary_board_id"], name: "index_salary_board_items_on_salary_board_id"
  end

  create_table "salary_boards", force: :cascade do |t|
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "salary_categories", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "salary_families", force: :cascade do |t|
    t.integer "code", null: false
    t.bigint "salary_grid_id"
    t.bigint "salary_category_id"
    t.bigint "salary_area_id"
    t.integer "family", null: false
    t.bigint "salary_layer_id"
    t.bigint "salary_group_id"
    t.integer "core", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["salary_area_id"], name: "index_salary_families_on_salary_area_id"
    t.index ["salary_category_id"], name: "index_salary_families_on_salary_category_id"
    t.index ["salary_grid_id"], name: "index_salary_families_on_salary_grid_id"
    t.index ["salary_group_id"], name: "index_salary_families_on_salary_group_id"
    t.index ["salary_layer_id"], name: "index_salary_families_on_salary_layer_id"
  end

  create_table "salary_grids", force: :cascade do |t|
    t.integer "number", null: false
    t.integer "code", null: false
    t.decimal "value_80", default: "0.0", null: false
    t.decimal "value_100", default: "0.0", null: false
    t.decimal "value_110", default: "0.0", null: false
    t.decimal "value_125", default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "value_105", default: "0.0", null: false
    t.decimal "value_115", default: "0.0", null: false
    t.decimal "value_120", default: "0.0", null: false
  end

  create_table "salary_groups", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "salary_layers", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "settings", force: :cascade do |t|
    t.string "entity_name"
    t.string "entity_address"
    t.string "entity_logo"
    t.string "framework_version"
    t.string "rails_version"
    t.string "ruby_version"
    t.text "plugins", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "youtube_api_key"
  end

  create_table "skills", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "kind", default: 0, null: false
  end

  create_table "social_security_tax_salaries", force: :cascade do |t|
    t.decimal "value", null: false
    t.bigint "salary_id"
    t.bigint "social_security_tax_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["salary_id"], name: "index_social_security_tax_salaries_on_salary_id"
    t.index ["social_security_tax_id"], name: "index_social_security_tax_salaries_on_social_security_tax_id"
  end

  create_table "social_security_taxes", force: :cascade do |t|
    t.string "name", null: false
    t.string "abbr_name", null: false
    t.decimal "percentage", default: "0.0", null: false
    t.decimal "percentage_from_employee", default: "0.0", null: false
    t.decimal "percentage_from_employer", default: "0.0", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subsidy_salaries", force: :cascade do |t|
    t.bigint "salary_id"
    t.bigint "subsidy_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "year"
    t.decimal "percentage", default: "0.0", null: false
    t.decimal "base_value", default: "0.0", null: false
    t.decimal "taxed_value", default: "0.0", null: false
    t.bigint "tax_type_id"
    t.index ["salary_id"], name: "index_subsidy_salaries_on_salary_id"
    t.index ["subsidy_type_id"], name: "index_subsidy_salaries_on_subsidy_type_id"
    t.index ["tax_type_id"], name: "index_subsidy_salaries_on_tax_type_id"
  end

  create_table "subsidy_types", force: :cascade do |t|
    t.string "name", null: false
    t.string "abbr_name", null: false
    t.string "code"
    t.integer "value_mode", default: 0, null: false
    t.decimal "value", default: "0.0", null: false
    t.boolean "for_all", default: true, null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "kind", default: 0, null: false
    t.boolean "is_taxed", default: false, null: false
  end

  create_table "tax_salaries", force: :cascade do |t|
    t.decimal "value", default: "0.0", null: false
    t.bigint "salary_id"
    t.bigint "tax_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["salary_id"], name: "index_tax_salaries_on_salary_id"
    t.index ["tax_type_id"], name: "index_tax_salaries_on_tax_type_id"
  end

  create_table "tax_types", force: :cascade do |t|
    t.string "name", null: false
    t.string "abbr_name", null: false
    t.string "code"
    t.integer "value_mode", default: 0, null: false
    t.decimal "value", default: "0.0", null: false
    t.boolean "for_all", default: true, null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "kind", default: 0, null: false
    t.decimal "percentage_from_employee", default: "0.0", null: false
    t.decimal "percentage_from_employer", default: "0.0", null: false
    t.decimal "exempt_up_to", default: "0.0", null: false
    t.decimal "max_wage", default: "0.0", null: false
    t.decimal "max_wage_fixed_portion", default: "0.0", null: false
    t.decimal "percentage_over_max_wage_excess", default: "0.0", null: false
    t.decimal "max_wage_excess_of", default: "0.0", null: false
  end

  create_table "team_goals", force: :cascade do |t|
    t.bigint "general_goal_id"
    t.bigint "assessment_id"
    t.integer "period", default: 0, null: false
    t.text "objectives", default: "", null: false
    t.float "target", default: 0.0, null: false
    t.integer "mode", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assessment_id"], name: "index_team_goals_on_assessment_id"
    t.index ["general_goal_id"], name: "index_team_goals_on_general_goal_id"
  end

  create_table "time_settings", force: :cascade do |t|
    t.integer "number_of_months_to_enjoy_vacation", default: 14, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "uploads", force: :cascade do |t|
    t.string "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: ""
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar"
    t.string "first_name"
    t.string "last_name"
    t.boolean "is_menu_minimized", default: false, null: false
    t.string "employee_number"
    t.bigint "employee_id"
    t.string "middle_name"
    t.string "cellphone"
    t.string "permissions", default: [], array: true
    t.integer "roles_mask", default: -1, null: false
    t.string "access", default: [], array: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["employee_id"], name: "index_users_on_employee_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vacancies", force: :cascade do |t|
    t.string "position", null: false
    t.text "requirements", null: false
    t.string "number"
    t.integer "status", default: 0, null: false
    t.integer "target", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "contract_type", default: 0, null: false
    t.date "offer_ends_at", default: "9999-01-01", null: false
    t.string "country", null: false
    t.string "city", null: false
    t.string "province", null: false
    t.string "job_description", null: false
    t.integer "year_of_experience", default: 0, null: false
  end

  create_table "vacation_approvers", force: :cascade do |t|
    t.bigint "employee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_vacation_approvers_on_employee_id"
  end

  create_table "vacation_days", force: :cascade do |t|
    t.bigint "employee_vacation_id"
    t.bigint "employee_avaliable_vacation_id"
    t.date "date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_avaliable_vacation_id"], name: "index_vacation_days_on_employee_avaliable_vacation_id"
    t.index ["employee_vacation_id"], name: "index_vacation_days_on_employee_vacation_id"
  end

  create_table "vacation_subsidies", force: :cascade do |t|
    t.string "name", null: false
    t.string "abbr_name", null: false
    t.decimal "percentage", default: "0.0", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vacation_subsidy_salaries", force: :cascade do |t|
    t.decimal "value", default: "0.0", null: false
    t.decimal "percentage", default: "100.0", null: false
    t.integer "year", null: false
    t.bigint "salary_id"
    t.bigint "vacation_subsidy_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["salary_id"], name: "index_vacation_subsidy_salaries_on_salary_id"
    t.index ["vacation_subsidy_id"], name: "index_vacation_subsidy_salaries_on_vacation_subsidy_id"
  end

  create_table "wage_income_tax_items", force: :cascade do |t|
    t.decimal "from", default: "0.0", null: false
    t.decimal "to", default: "0.0", null: false
    t.decimal "fixed_portion", default: "0.0", null: false
    t.decimal "percentage_over_the_excess", default: "0.0", null: false
    t.decimal "excess_of", default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "tax_type_id"
    t.index ["tax_type_id"], name: "index_wage_income_tax_items_on_tax_type_id"
  end

  create_table "wage_income_tax_salaries", force: :cascade do |t|
    t.decimal "value", default: "0.0", null: false
    t.bigint "salary_id"
    t.bigint "wage_income_tax_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["salary_id"], name: "index_wage_income_tax_salaries_on_salary_id"
    t.index ["wage_income_tax_id"], name: "index_wage_income_tax_salaries_on_wage_income_tax_id"
  end

  create_table "wage_income_taxes", force: :cascade do |t|
    t.string "name", null: false
    t.string "abbr_name", null: false
    t.decimal "exempt_up_to", default: "0.0", null: false
    t.decimal "max_wage", default: "0.0", null: false
    t.decimal "max_wage_fixed_portion", default: "0.0", null: false
    t.decimal "percentage_over_max_wage_excess", default: "0.0", null: false
    t.decimal "max_wage_excess_of", default: "0.0", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "absence_days", "employee_absences"
  add_foreign_key "applications", "next_sgad_employees", column: "employee_id"
  add_foreign_key "applications", "vacancies"
  add_foreign_key "approvers", "absence_types"
  add_foreign_key "approvers", "next_sgad_employees", column: "employee_id"
  add_foreign_key "chapters", "courses"
  add_foreign_key "christmas_subsidy_salaries", "christmas_subsidies"
  add_foreign_key "christmas_subsidy_salaries", "salaries"
  add_foreign_key "corporate_goals", "general_goals"
  add_foreign_key "corporate_goals", "next_sgad_assessments", column: "assessment_id"
  add_foreign_key "course_obligated_functions", "courses"
  add_foreign_key "course_obligated_functions", "next_sgad_functions", column: "function_id"
  add_foreign_key "course_optional_functions", "courses"
  add_foreign_key "course_optional_functions", "next_sgad_functions", column: "function_id"
  add_foreign_key "directorates", "directorate_areas"
  add_foreign_key "directorates", "pelouros"
  add_foreign_key "employee_absences", "absence_types"
  add_foreign_key "employee_absences", "next_sgad_employees", column: "employee_id"
  add_foreign_key "employee_answers", "employee_questions"
  add_foreign_key "employee_avaliable_vacations", "next_sgad_employees", column: "employee_id"
  add_foreign_key "employee_chapters", "chapters"
  add_foreign_key "employee_chapters", "employee_courses"
  add_foreign_key "employee_courses", "courses"
  add_foreign_key "employee_courses", "next_sgad_employees", column: "employee_id"
  add_foreign_key "employee_delays", "absence_types"
  add_foreign_key "employee_delays", "next_sgad_employees", column: "employee_id"
  add_foreign_key "employee_exams", "employee_chapters"
  add_foreign_key "employee_exams", "exams"
  add_foreign_key "employee_exits", "absence_types"
  add_foreign_key "employee_exits", "next_sgad_employees", column: "employee_id"
  add_foreign_key "employee_justifications", "employee_absences"
  add_foreign_key "employee_justifications", "employee_delays"
  add_foreign_key "employee_justifications", "employee_exits"
  add_foreign_key "employee_justifications", "next_sgad_employees", column: "employee_id"
  add_foreign_key "employee_lessons", "employee_chapters"
  add_foreign_key "employee_lessons", "lessons"
  add_foreign_key "employee_paygrades", "next_sgad_employees", column: "employee_id"
  add_foreign_key "employee_paygrades", "paygrade_change_reasons"
  add_foreign_key "employee_presences", "next_sgad_employees", column: "employee_id"
  add_foreign_key "employee_question_options", "employee_questions"
  add_foreign_key "employee_question_options", "question_options"
  add_foreign_key "employee_questions", "employee_exams"
  add_foreign_key "employee_questions", "questions"
  add_foreign_key "employee_regimes", "next_sgad_employees", column: "employee_id"
  add_foreign_key "employee_requests", "next_sgad_employees", column: "employee_id"
  add_foreign_key "employee_requests", "request_types"
  add_foreign_key "employee_salary_families", "next_sgad_employees", column: "employee_id"
  add_foreign_key "employee_salary_families", "paygrade_change_reasons"
  add_foreign_key "employee_salary_families", "salary_families"
  add_foreign_key "employee_skills", "next_sgad_employees", column: "employee_id"
  add_foreign_key "employee_skills", "skills"
  add_foreign_key "employee_vacation_responses", "employee_vacations"
  add_foreign_key "employee_vacation_responses", "next_sgad_employees", column: "employee_id"
  add_foreign_key "employee_vacations", "next_sgad_employees", column: "employee_id"
  add_foreign_key "employee_work_periods", "next_sgad_employees", column: "employee_id"
  add_foreign_key "establishments", "establishment_types"
  add_foreign_key "establishments", "establishments"
  add_foreign_key "establishments", "municipalities"
  add_foreign_key "establishments", "next_sgad_positions", column: "position_id"
  add_foreign_key "exams", "chapters"
  add_foreign_key "function_skills", "next_sgad_functions", column: "function_id"
  add_foreign_key "function_skills", "skills"
  add_foreign_key "general_goals", "next_sgad_assessments", column: "assessment_id"
  add_foreign_key "individual_goals", "next_sgad_employees", column: "employee_id"
  add_foreign_key "justification_answers", "employee_justifications"
  add_foreign_key "justification_answers", "next_sgad_employees", column: "employee_id"
  add_foreign_key "lessons", "chapters"
  add_foreign_key "municipalities", "provinces"
  add_foreign_key "next_sgad_attendances", "next_sgad_assessments", column: "assessment_id"
  add_foreign_key "next_sgad_attendances", "next_sgad_departments", column: "department_id"
  add_foreign_key "next_sgad_attendances", "next_sgad_employees", column: "employee_id"
  add_foreign_key "next_sgad_attendances", "next_sgad_positions", column: "position_id"
  add_foreign_key "next_sgad_departments", "next_sgad_departments"
  add_foreign_key "next_sgad_departments", "next_sgad_departments", column: "department_id"
  add_foreign_key "next_sgad_departments", "next_sgad_employees", column: "employee_id"
  add_foreign_key "next_sgad_employee_goal_activities", "next_sgad_employee_goals", column: "employee_goal_id"
  add_foreign_key "next_sgad_employee_goals", "next_sgad_assessments", column: "assessment_id"
  add_foreign_key "next_sgad_employee_goals", "next_sgad_employees", column: "employee_id"
  add_foreign_key "next_sgad_employee_goals", "next_sgad_goals", column: "goal_id"
  add_foreign_key "next_sgad_employee_goals", "next_sgad_positions", column: "position_id"
  add_foreign_key "next_sgad_employee_messages", "next_sgad_employees", column: "employee_id"
  add_foreign_key "next_sgad_employee_messages", "next_sgad_messages", column: "message_id"
  add_foreign_key "next_sgad_employees_assessments", "next_sgad_assessments", column: "assessment_id"
  add_foreign_key "next_sgad_employees_assessments", "next_sgad_employees", column: "employee_id"
  add_foreign_key "next_sgad_functions", "directorates"
  add_foreign_key "next_sgad_functions", "function_contract_types"
  add_foreign_key "next_sgad_functions", "function_deslocation_regimes"
  add_foreign_key "next_sgad_functions", "organic_units"
  add_foreign_key "next_sgad_goals", "next_sgad_assessments", column: "assessment_id"
  add_foreign_key "next_sgad_goals", "next_sgad_goal_units", column: "goal_unit_id"
  add_foreign_key "next_sgad_justifications", "next_sgad_employees", column: "employee_id"
  add_foreign_key "next_sgad_positions", "establishments"
  add_foreign_key "next_sgad_positions", "next_sgad_departments", column: "department_id"
  add_foreign_key "next_sgad_positions", "next_sgad_employees", column: "efective_id"
  add_foreign_key "next_sgad_positions", "next_sgad_functions", column: "function_id"
  add_foreign_key "next_sgad_positions", "next_sgad_positions", column: "position_id"
  add_foreign_key "next_sgad_positions", "organic_units"
  add_foreign_key "next_sgad_results", "next_sgad_employee_goals", column: "employee_goal_id"
  add_foreign_key "notifications_employee", "next_sgad_employees", column: "employee_id"
  add_foreign_key "notifications_employee", "next_sgad_employees", column: "notification_id"
  add_foreign_key "object_approvers", "next_sgad_employees", column: "employee_id"
  add_foreign_key "object_responses", "next_sgad_employees", column: "employee_id"
  add_foreign_key "organic_units", "organic_unit_types"
  add_foreign_key "organic_units", "organic_units"
  add_foreign_key "organic_units", "pelouros"
  add_foreign_key "pelouros", "next_sgad_employees", column: "employee_id"
  add_foreign_key "question_options", "questions"
  add_foreign_key "questions", "exams"
  add_foreign_key "report_reviewers", "next_sgad_employees", column: "employee_id"
  add_foreign_key "reports", "next_sgad_employees", column: "employee_id"
  add_foreign_key "salaries", "employee_paygrades"
  add_foreign_key "salaries", "employee_salary_families"
  add_foreign_key "salary_board_items", "salary_boards"
  add_foreign_key "salary_families", "salary_areas"
  add_foreign_key "salary_families", "salary_categories"
  add_foreign_key "salary_families", "salary_grids"
  add_foreign_key "salary_families", "salary_groups"
  add_foreign_key "salary_families", "salary_layers"
  add_foreign_key "social_security_tax_salaries", "salaries"
  add_foreign_key "social_security_tax_salaries", "social_security_taxes"
  add_foreign_key "subsidy_salaries", "salaries"
  add_foreign_key "subsidy_salaries", "subsidy_types"
  add_foreign_key "subsidy_salaries", "tax_types"
  add_foreign_key "tax_salaries", "salaries"
  add_foreign_key "tax_salaries", "tax_types"
  add_foreign_key "team_goals", "general_goals"
  add_foreign_key "team_goals", "next_sgad_assessments", column: "assessment_id"
  add_foreign_key "users", "next_sgad_employees", column: "employee_id"
  add_foreign_key "vacation_approvers", "next_sgad_employees", column: "employee_id"
  add_foreign_key "vacation_days", "employee_avaliable_vacations"
  add_foreign_key "vacation_days", "employee_vacations"
  add_foreign_key "vacation_subsidy_salaries", "salaries"
  add_foreign_key "vacation_subsidy_salaries", "vacation_subsidies"
  add_foreign_key "wage_income_tax_items", "tax_types"
  add_foreign_key "wage_income_tax_salaries", "salaries"
  add_foreign_key "wage_income_tax_salaries", "wage_income_taxes"
end
