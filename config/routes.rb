Rails.application.routes.draw do
  resources :organic_units
  resources :organic_unit_types
  resources :establishments
  resources :establishment_types
  resources :municipalities
  resources :provinces
  get "app" => 'landing#index', as: :vue_app

  resources :team_goals
  resources :corporate_goals
  resources :general_goals
  resources :groups
  resources :employee_presences
  resources :absence_days
  # resources :vacation_days
  # resources :employee_avaliable_vacations
  resources :time_settings
  get 'latest_time_setting' => 'time_settings#latest', as: :latest_time_setting
  resources :employee_vacation_responses, only: [:update]
  resources :employee_vacations, only: [:create, :new, :destroy, :update, :edit]
  get 'employee_lessons/:id/edit_vacation' => 'employee_lessons#edit_vacation', as: :edit_vacation
  patch 'employee_lessons/:id/update_vacation' => 'employee_lessons#update_vacation', as: :update_vacation
  resources :vacation_approvers, only: [:index, :create, :new, :destroy]
  resources :function_settings
  resources :pelouros
  resources :directorates
  resources :directorate_areas, only: [:index, :create, :new, :destroy, :update]
  resources :course_optional_functions
  resources :course_obligated_functions
  resources :object_videos
  resources :employee_questions
  resources :employee_chapters
  resources :employee_answers
  resources :employee_question_options
  patch 'employee_question_options/:id/select' => 'employee_question_options#select', as: :select_employee_question_option
  resources :employee_exams
  patch 'employee_exams/:id/start' => 'employee_exams#start', as: :start_employee_exam
  patch 'employee_exams/:id/complete' => 'employee_exams#complete', as: :complete_employee_exam
  resources :employee_lessons
  patch 'employee_lessons/:id/watch' => 'employee_lessons#watch', as: :watch_employee_lesson
  resources :employee_courses
  patch 'employee_courses/:id/complete' => 'employee_courses#complete', as: :complete_course
  resources :question_options
  resources :questions
  resources :chapters
  resources :exams
  resources :lessons
  patch 'lessons/:id/file_upload' => 'lessons#file_upload', as: :lesson_file_upload
  resources :courses

  get "report_courses" => "courses#report_courses", as: :report_courses
  patch "chapters/:id/create_exam", to: "chapters#create_exam", as: :create_exam

  patch 'courses/:id/start_course' => 'courses#start', as: :start_course
  get 'courses/:id/see_course' => 'courses#see', as: :see_course
  get 'courses/:id/continue_course' => 'courses#continue', as: :continue_course
  patch 'courses/:id/restart_course' => 'courses#restart', as: :restart_course
  patch 'courses/:id/open_course' => 'courses#open', as: :open_course
  patch 'courses/:id/close_course' => 'courses#close', as: :close_course
  patch 'courses/:id/draft_course' => 'courses#draft', as: :draft_course
  get 'courses/:id/statistics' => 'courses#statistics', as: :course_statistics
  get 'my_training' => 'courses#my_training', as: :my_training

  resources :function_skills
  resources :employee_skills
  resources :skills, only: [:create, :new, :destroy, :update]
  get 'skills_map' => 'skills#skills_map', as: :skills_map
  resources :function_deslocation_regimes, only: [:create, :new, :destroy]
  resources :function_contract_types, only: [:create, :new, :destroy]
  resources :function_areas, only: [:create, :new, :destroy]
  resources :function_subsidies, only: [:create, :new, :destroy]
  resources :function_autonomy_levels, only: [:create, :new, :destroy]
  resources :employee_salary_families, only: [:create, :new, :destroy]
  resources :salary_families, only: [:create, :new, :destroy]
  resources :salary_groups, only: [:create, :new, :destroy]
  resources :salary_layers, only: [:create, :new, :destroy]
  resources :salary_areas, only: [:create, :new, :destroy]
  resources :salary_categories, only: [:create, :new, :destroy]
  resources :salary_grids, only: [:create, :new, :destroy]
  patch 'add_salary_grid' => 'salary_grids#add_grid', as: :add_salary_grid
  patch 'remove_salary_grid' => 'salary_grids#remove_grid', as: :remove_salary_grid
  resources :applications
  get 'create_application' => 'applications#create_application', as: :create_application
  patch 'applications/:id/mark_as_relevant' => 'applications#mark_as_relevant', as: :mark_application_as_relevant
  patch 'applications/:id/mark_as_irrelevant' => 'applications#mark_as_irrelevant', as: :mark_application_as_irrelevant
  resources :vacancies
  get "candidaturas" => "vacancies#index", as: :candidaturas
  resources :appliances, only: [:new, :create, :index, :destroy, :show, :update]
  resources :reports, only: [:new, :create, :index, :destroy, :show]
  resources :report_reviewers, only: [:new, :create, :index, :destroy]
  resources :employee_requests
  resources :object_approvers
  resources :request_types
  resources :object_attachments
  resources :object_activities
  resources :absence_types do
    resources :approvers
  end
  resources :date_types
  # resources :assessment_settings
  # get 'latest_assessment_setting' => 'assessment_settings#latest', as: :latest_assessment_setting
  resources :remuneration_settings, only: [:new, :create, :edit]
  get 'latest_remuneration_setting' => 'remuneration_settings#latest', as: :latest_remuneration_setting
  resources :salary_boards, only: [:new, :create, :edit]
  get 'latest_salary_board' => 'salary_boards#latest', as: :latest_salary_board
  # não estão em uso para remover
    # resources :social_security_tax_salaries
    # resources :wage_income_tax_salaries
    # resources :christmas_subsidy_salaries
    # resources :vacation_subsidy_salaries
    # resources :social_security_taxes
    # get 'latest_social_security_tax' => 'social_security_taxes#latest', as: :latest_social_security_tax
    # resources :wage_income_tax_items
    # resources :wage_income_taxes
    # get 'latest_wage_income_tax' => 'wage_income_taxes#latest', as: :latest_wage_income_tax
    # resources :christmas_subsidies
    # get 'latest_christmas_subsidy' => 'christmas_subsidies#latest', as: :latest_christmas_subsidy
    # resources :vacation_subsidies
    # get 'latest_vacation_subsidy' => 'vacation_subsidies#latest', as: :latest_vacation_subsidy
  #
  # resources :tax_salaries Não precisa de views
  # resources :subsidy_salaries Não precisa de views
  resources :tax_types
  get 'partial_view_tax_types' => 'tax_types#partial_view_tax_types', as: :partial_view_tax_types
  resources :subsidy_types
  get 'partial_view_subsidy_types' => 'subsidy_types#partial_view_subsidy_types', as: :partial_view_subsidy_types
  resources :paygrade_change_reasons
  get 'partial_view_paygrade_change_reasons' => 'paygrade_change_reasons#partial_view_paygrade_change_reasons', as: :partial_view_paygrade_change_reasons
  # resources :employee_paygrades
  resources :salaries
  get 'new_salary_map' => 'salaries#new_salary_map', as: :new_salary_map
  post 'create_salary_map' => 'salaries#create_salary_map', as: :create_salary_map
  get 'salaries/:id/partial_view_salary' => 'salaries#partial_view_salary', as: :partial_view_salary
  patch 'salaries/:id/subsidies/:subsidy_type_id/add_subsidy' => 'salaries#add_subsidy', as: :salary_add_subsidy
  patch 'salaries/:id/taxes/:tax_type_id/add_tax' => 'salaries#add_tax', as: :salary_add_tax
  patch 'salaries/:id/subsidies/:subsidy_salary_id/remove_subsidy' => 'salaries#remove_subsidy', as: :salary_remove_subsidy
  patch 'salaries/:id/taxes/:tax_salary_id/remove_tax' => 'salaries#remove_tax', as: :salary_remove_tax
  patch 'salaries/:id/pay' => 'salaries#pay', as: :salary_pay
  patch 'salaries/:id/activate' => 'salaries#activate', as: :salary_activate
  resources :employee_work_periods
  resources :photos
  #
  # Routes are organized by each resource in alphabetic order
  #
  #-----------------------------------------------------------------------------------

  # app root
  root to: 'dashboard#index'
  #-----------------------------------------------------------------------------------

  # assessments
  resources :assessments, controller: 'nextsgad/assessments'
  get 'assessments/:id/new_goal' => 'nextsgad/assessments#new_goal', as: :assessment_new_goal
  post 'assessments/:id/create_goal' => 'nextsgad/assessments#create_goal', as: :assessment_create_goal
  get 'assessments/:id/new_skill' => 'nextsgad/assessments#new_skill', as: :assessment_new_skill
  post 'assessments/:id/create_skill' => 'nextsgad/assessments#create_skill', as: :assessment_create_skill
  get 'assessments/:id/new_objective' => 'nextsgad/assessments#new_objective', as: :assessment_new_objective
  post 'assessments/:id/create_objective' => 'nextsgad/assessments#create_objective', as: :assessment_create_objective
  get 'assessments/:id/assessments_map' => 'nextsgad/assessments#assessments_map', as: :assessments_map
  get 'old_assessments_export' => 'nextsgad/assessments#old_assessments_export', as: :old_assessments_export
  patch 'assessments/:id/activate' => 'nextsgad/assessments#activate', as: :activate_assessment
  patch 'assessments/:id/close' => 'nextsgad/assessments#close', as: :close_assessment
  patch 'assessments/:id/deactivate' => 'nextsgad/assessments#deactivate', as: :deactivate_assessment
  patch 'assessments/:id/draft' => 'nextsgad/assessments#draft', as: :draft_assessment
  get 'assessments/:id/new_skills_from_last_year' => 'nextsgad/assessments#new_skills_from_last_year', as: :new_skills_from_last_year
  post 'assessments/:id/create_skills_from_last_year' => 'nextsgad/assessments#create_skills_from_last_year', as: :create_skills_from_last_year
  get 'assessments/:year/reports' => 'nextsgad/assessments#reports', as: :assessment_reports
  #-----------------------------------------------------------------------------------

  # activities
  resources :activities, controller: 'nextsgad/activities'
  patch 'nextsgad/activities/:id/change_status_activity' => 'nextsgad/activities#change_status_activity', as: 'change_status_activity'

  #-----------------------------------------------------------------------------------


  # attendances
  # resources :attendances, controller: 'nextsgad/attendances'
  # get 'my_attendances' => 'nextsgad/attendances#my_attendances', as: :my_attendances
  # get 'my_team_attendances' => 'nextsgad/attendances#my_team_attendances', as: :my_team_attendances
  #-----------------------------------------------------------------------------------

  # dashboard Resource
  get 'dashboard/index'
  #-----------------------------------------------------------------------------------

  # departments
  resources :departments, controller: 'nextsgad/departments'

  get 'departments_organigram' => 'nextsgad/departments#organigram', as: 'departments_organigram'
  #-----------------------------------------------------------------------------------

  # devise admins
  devise_for :admins, controllers: {
      sessions: 'admins/sessions',
      registrations: 'admins/registrations',
      passwords: 'admins/passwords'
  }
  as :admin do
    get 'admins/edit' => 'admins/registrations#edit', as: 'edit_admin_registration'
    put 'admins' => 'admins/registrations#update', as: 'admin_registration'
  end
  #-----------------------------------------------------------------------------------

  # devise users
  devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations',
      passwords: 'users/passwords'
  }
  as :user do
    get 'users/edit' => 'users/registrations#edit', as: 'edit_user_registration'
    put 'users' => 'users/registrations#update', as: 'user_registration'
  end
  resources :users
  patch 'users/:id/reset_password' => 'users#reset_password', as: 'user_reset_password'
  patch 'users/:id/generate_password' => 'users#generate_password', as: 'user_generate_password'
  #-----------------------------------------------------------------------------------

  # employee_goals
  resources :employee_goals, controller: 'nextsgad/employee_goals'
  patch 'employee_goals/:id/change_status_employee_goal' => 'nextsgad/employee_goals#change_status_employee_goal', as: :change_status_employee_goal
  get 'employee_goals/:id/partial_view_show' => 'nextsgad/employee_goals#partial_view_show', as: :employee_goal_partial_view_show

  #-----------------------------------------------------------------------------------

  # employee_goal_activities
  resources :employee_goal_activities, controller: 'nextsgad/employee_goal_activities', only: [:new, :create]
  #-----------------------------------------------------------------------------------
  resources :justification_answers, only: [:new, :create, :show, :edit, :update]

  # employees
  resources :employees, controller: 'nextsgad/employees' do

  # employee_messages
  resources :employee_messages, controller: 'nextsgad/employee_messages'
  #-----------------------------------------------------------------------------------

  # employee_absences
  resources :employee_absences, only: [:new, :create, :show, :edit, :update, :destroy]
  #-----------------------------------------------------------------------------------

  # employee_exits
  resources :employee_exits, only: [:new, :create, :show, :edit, :update, :destroy]
  #-----------------------------------------------------------------------------------

  # employee_delays
  resources :employee_delays, only: [:new, :create, :show, :edit, :update, :destroy]
  #-----------------------------------------------------------------------------------

  # employee_vacations
  resources :employee_vacations, only: [:create, :new, :destroy, :update, :edit]
  #-----------------------------------------------------------------------------------

  # employee_regimes
  resources :employee_regimes, only: [:new, :create, :show, :edit, :update, :destroy]
  #-----------------------------------------------------------------------------------

  resources :employee_justifications, only: [:new, :create, :show, :edit, :update, :destroy] do
    # patch 'justification_answers/:id/approved' => 'justification_answers#approved', as: :approve
    # patch 'justification_answers/:id/not_approved' => 'justification_answers#not_approved', as: :not_approve
  end
  patch 'employee_justifications/:id/:kind/:status/add_answer' => 'employee_justifications#add_answer', as: :add_answer

  get 'new_justification' => 'employee_justifications#new_justification', as: :new_justification
  post 'create_justification' => 'employee_justifications#create_justification', as: :create_justification
  get 'new_absence' => 'employee_absences#new_absence', as: :new_absence
  post 'create_absence' => 'employee_absences#create_absence', as: :create_absence
  patch 'employee_absences/:id/mark_presence' => 'employee_absences#mark_presence', as: :mark_presence
  patch 'employee_absences/:id/mark_employee_presence' => 'employee_absences#mark_employee_presence', as: :mark_employee_presence
  patch 'employee_presences/:id/confirm_employee_presence' => 'employee_presences#confirm_employee_presence', as: :confirm_employee_presence
  get 'new_presence' => 'employee_presences#new_presence', as: :new_presence
  post 'create_presence' => 'employee_presences#create_presence', as: :create_presence
  get 'new_delay' => 'employee_delays#new_delay', as: :new_delay
  post 'create_delay' => 'employee_delays#create_delay', as: :create_delay
  get 'new_exit' => 'employee_exits#new_exit', as: :new_exit
  post 'create_exit' => 'employee_exits#create_exit', as: :create_exit

  get 'new_vacation' => 'employee_vacations#new_vacation', as: :new_vacation
  post 'create_vacation' => 'employee_vacations#create_vacation', as: :create_vacation

  end
  get 'employees/:id/:day/:month/:year/presence' => 'nextsgad/employees#presence', as: :employee_attendance
  get 'employees/:id/notification_show' => 'nextsgad/employees#notification_show', as: :notification_show
  get 'employees/:id/notification_read' => 'nextsgad/employees#notification', as: :notification_read
  get 'employees/:id/notification_read_all' => 'nextsgad/employees#notification_read_all', as: :notification_read_all

  # get 'employees/:id/employee_show' => 'nextsgad/employees#employee_show', as: :employee_employee_show
  get 'my_team' => 'nextsgad/employees#my_team', as: :my_team
  post 'employee/:id/create_objective' => 'nextsgad/employees#create_objective', as: :employee_create_objective
  get 'my_team_assessment' => 'nextsgad/employees#my_team_assessment', as: :my_team_assessment
  get 'my_data' => 'nextsgad/employees#my_data', as: :my_data
  get 'my_reports' => 'nextsgad/employees#my_reports', as: :my_reports

  # report status
  get 'reports/:id/open_report' => 'reports#open_report', as: :open_report
  get 'reports/:id/cancel_report' => 'reports#cancel_report', as: :cancel_report


  get 'my_requests' => 'nextsgad/employees#my_requests', as: :my_requests
  get 'hr_presence_map' => 'nextsgad/employees#hr_presence_map', as: :hr_presence_map
  get 'my_team_presence_map' => 'nextsgad/employees#my_team_presence_map', as: :my_team_presence_map
  get 'department_presence_map' => 'nextsgad/employees#department_presence_map', as: :department_presence_map
  get 'my_presence_map' => 'nextsgad/employees#my_presence_map', as: :my_presence_map
  #get 'employees/:id/assessment' => 'nextsgad/employees#assessment', as: :employee_assessment
  get 'employees/:id/team_member_data' => 'nextsgad/employees#team_member_data', as: :team_member_data
  get 'employees/:id/pick_position' => 'nextsgad/employees#pick_position', as: :employee_pick_position
  patch 'employees/:id/select_position' => 'nextsgad/employees#select_position', as: :employee_select_position
  get 'employees/:id/partial_view_list_employee_paygrades' => 'nextsgad/employees#partial_view_list_employee_paygrades', as: :partial_view_list_employee_paygrades
  get 'employees/:id/partial_view_list_employee_work_periods' => 'nextsgad/employees#partial_view_list_employee_work_periods', as: :partial_view_list_employee_work_periods
  get 'employees/:id/partial_view_list_employee_salaries' => 'nextsgad/employees#partial_view_list_employee_salaries', as: :partial_view_list_employee_salaries
  get 'employees/:id/assessments/:assessment_id/new_employee_objective' => 'nextsgad/employees#new_employee_objective', as: :new_employee_objective
  post 'employees/:id/assessments/:assessment_id/create_employee_objective' => 'nextsgad/employees#create_employee_objective', as: :create_employee_objective
  #-----------------------------------------------------------------------------------

  # functions
  resources :functions, controller: 'nextsgad/functions'
  get 'functions_settings' => 'nextsgad/functions#settings', as: :functions_settings
  patch 'functions/:id/toogle_area' => 'nextsgad/functions#toogle_area', as: :function_toogle_area
  patch 'functions/:id/toogle_contract_type' => 'nextsgad/functions#toogle_contract_type', as: :function_toogle_contract_type
  patch 'functions/:id/toogle_autonomy' => 'nextsgad/functions#toogle_autonomy', as: :function_toogle_autonomy
  patch 'functions/:id/toogle_subsidy' => 'nextsgad/functions#toogle_subsidy', as: :function_toogle_subsidy
  patch 'functions/:id/toogle_qualification_kind' => 'nextsgad/functions#toogle_qualification_kind', as: :function_toogle_qualification_kind
  patch 'functions/:id/toogle_experience_kind' => 'nextsgad/functions#toogle_experience_kind', as: :function_toogle_experience_kind
  #-----------------------------------------------------------------------------------

  # goals
  resources :goals, controller: 'nextsgad/goals'
  get 'reload_goals' => 'nextsgad/goals#reload', as: :reload_goals
  #-----------------------------------------------------------------------------------

  # goal_units
  resources :goal_units, controller: 'nextsgad/goal_units'
  #-----------------------------------------------------------------------------------

  # justifications
  # resources :justifications,  controller: 'nextsgad/justifications'
  # patch 'justifications/:id/aprove'    => 'nextsgad/justifications#aprove', as: :aprove_justification
  # patch 'justifications/:id/disaprove' => 'nextsgad/justifications#disaprove', as: :disaprove_justification
  #-----------------------------------------------------------------------------------

  # letter_oppener
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
  #-----------------------------------------------------------------------------------

  # next_sgad
  #mount Engine, at: "/sgad"
  get 'sgad' => 'nextsgad/positions#index', as: 'sgad'
  #-----------------------------------------------------------------------------------

  # others
  patch 'application/toogle_menu'
  #-----------------------------------------------------------------------------------

  # plugins
  resources :plugins
  post 'plugins' => 'plugins#create', as: 'create_plugin'
  #-----------------------------------------------------------------------------------

  # positions
  resources :positions, controller: 'nextsgad/positions'
  post 'create_position' => 'nextsgad/positions#create_position', as: 'create_position'

  get 'organigram' => 'nextsgad/positions#organigram', as: 'organigram'
  get 'my_orgchart'       => 'nextsgad/positions#my_orgchart',      as: 'my_orgchart'
  get 'my_team_orgchart'  => 'nextsgad/positions#my_team_orgchart', as: 'my_team_orgchart'

  #-----------------------------------------------------------------------------------

  # # PaygradeBoards
  # resources :paygrade_boards
  # get 'latest' => 'paygrade_boards#latest', as: :latest_paygrade_board
  # #-----------------------------------------------------------------------------------

  # roles
  resources :roles
  #-----------------------------------------------------------------------------------

  # employee_goals
  resources :results, controller: 'nextsgad/results'
  get 'change_status' => 'nextsgad/results#change_status', as: 'change_status'

  #-----------------------------------------------------------------------------------

  # object_responses
  patch 'object_responses/:id/approve' => 'object_responses#approve', as: :approve_object_response
  patch 'object_responses/:id/disaprove' => 'object_responses#disaprove', as: :disaprove_object_response
  patch 'object_responses/:id/remove' => 'object_responses#remove', as: :remove_object_response
  #-----------------------------------------------------------------------------------

  # messages
  resources :messages, controller: 'nextsgad/messages'
  #-----------------------------------------------------------------------------------

  # settings
  get 'settings' => "settings#show", :as => 'settings'
  get 'settings/edit' => 'settings#edit', :as => 'edit_settings'
  put 'settings' => 'settings#update'
  patch 'settings' => 'settings#update'
  #-----------------------------------------------------------------------------------


  # Uploads
  resources :uploads
  # departments upload
  get 'upload_departments' => 'uploads#upload_departments'
  post 'create_departments' => 'uploads#create_departments'
  # functions upload
  get 'upload_functions' => 'uploads#upload_functions'
  post 'create_functions' => 'uploads#create_functions'
  # employees upload
  get 'upload_employees' => 'uploads#upload_employees'
  post 'create_employees' => 'uploads#create_employees'
  # positions upload
  get 'upload_positions' => 'uploads#upload_positions'
  post 'create_positions' => 'uploads#create_positions'
  # attendances upload
  get 'upload_attendances' => 'uploads#upload_attendances'
  post 'create_attendances' => 'uploads#create_attendances'
  # justifications upload
  get 'upload_justifications' => 'uploads#upload_justifications'
  post 'create_justifications' => 'uploads#create_justifications'
  # users upload
  get 'upload_users' => 'uploads#upload_users'
  post 'create_users' => 'uploads#create_users'
  #-----------------------------------------------------------------------------------
end
