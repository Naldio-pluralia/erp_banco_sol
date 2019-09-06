class Plugin < ApplicationRecord
  has_many :children, dependent: :destroy, class_name: :parent_id
  validates :name, presence: {message: "A module needs a name"}
  acts_as_tree order: "name"

  # Get All plugins withou parents
  def self.roots
    Plugin.where(parent_id: nil)
  end

  # Get all plugins as hash with parent_id as the key
  def self.as_hash
    Plugin.all.group_by {|p| p.parent_id}
  end

  def self.generate_side_menu(destroy_others = false)
    Plugin.destroy_all if destroy_others
    menus = [
        {name: :dashboard, description: :dashboard, url: :root_url, icon: :business_at_mtl, order: 0},
        {name: :employees_administration, description: :employees_administration, icon: :people_at_mtl, order: 1, plugins: [

          {name: :performance_evaluation, description: :performance_evaluation, icon: :view_list_at_mtl, order: 0, plugins: [
            {name: :assessments, description: :assessments, icon: :apps_at_mtl, url: :assessments_url, order: 1, if_can: 'index,assessments'},
            {name: :goals, description: :goals, icon: :blur_linear_at_mtl, url: :goals_url, order: 2, if_can: 'index,goals'},
            {name: :general_goals, description: :general_goals, icon: :blur_linear_at_mtl, url: :general_goals_url, order: 2, if_can: 'index,general_goals'},
            {name: :corporate_goals, description: :corporate_goals, icon: :blur_linear_at_mtl, url: :corporate_goals_url, order: 2, if_can: 'index,corporate_goals'},
            {name: :team_goals, description: :team_goals, icon: :blur_linear_at_mtl, url: :team_goals_url, order: 2, if_can: 'index,team_goals'},
            {name: :reports, description: :reports, icon: :show_chart_at_mtl, url: :default_assessment_reports_url, order: 4, if_can: 'reports,assessments'}
          ]},

          {name: :employees, description: :employees, icon: :portrait_at_mtl, url: :employees_url, order: 3, if_can: 'index,employees'},
          {name: :organic_units, description: :organic_units, icon: :crop_at_mtl, url: :"vue_app_url,/organic_units", order: 4, if_can: 'index,organic_units'},
          {name: :establishments, description: :establishments, icon: :crop_at_mtl, url: :"vue_app_url,/establishments", order: 4, if_can: 'index,establishments'},
          {name: :function_settings, description: :function_settings, icon: :settings_at_mtl, url: :functions_settings_url, order: 5, if_can: 'settings,functions'},
          {name: :functions, description: :functions, icon: :picture_in_picture_at_mtl, url: :functions_url, order: 6, if_can: 'index,functions'},
          {name: :pelouros, description: :pelouros, icon: :picture_in_picture_alt_at_mtl, url: :pelouros_url, order: 7, if_can: 'index,pelouros'},
          {name: :organigram, description: :organigram, icon: :device_hub_at_mtl, url: :organigram_url, order: 9, if_can: 'organigram,positions'},
          {name: :positions, description: :positions, icon: :crop_landscape_at_mtl, url: :positions_url, order: 10, if_can: 'index,positions'},
          {name: :groups, description: :groups, icon: :people_at_mtl, url: :groups_url, order: 10, if_can: 'index,positions'}

        ]},

        {name: :academy, description: :academy, icon: :business_center_at_mtl, order: 2, plugins: [
          {name: :courses, description: :courses, icon: :school_at_mtl, url: :courses_url, order: 0, if_can: 'index,courses'},
          {name: :report_courses, description: :report_courses, icon: :show_chart_at_mtl, url: :report_courses_url, order: 1, if_can: 'index,courses'}
        ]},

        {name: :applications, description: :applications, icon: :view_list_at_mtl, order: 3, plugins: [
          {name: :vacancies, description: :vacancies, icon: :assignment_turned_in_at_mtl, url: :vacancies_url, order: 1, if_can: 'index,vacancies'},
          {name: :spontaneous_applications, description: :spontaneous_applications, icon: :assignment_id_at_mtl, url: :applications_url, order: 2, if_can: 'index,applications'},
        ]},

        {name: :comunication, description: :comunication, icon: :chat_bubble_outline_at_mtl, order: 4, plugins: [
          {name: :employee_requests, description: :requests, icon: :chat_at_mtl, order: 0, plugins: [
            {name: :request_types, description: :request_types, icon: :merge_type_hub_at_mtl, url: :request_types_url, order: 1, if_can: 'index,request_types'},
            {name: :employee_requests, description: :employee_requests, icon: :chat_at_mtl, url: :employee_requests_url, order: 2, if_can: 'index,employee_requests'}
          ]},
          {name: :denuncias, description: :denuncias, icon: :chat_bubble_at_mtl, order: 1, plugins: [
            {name: :report_reviewers, description: :report_reviewers, icon: :work_hub_at_mtl, url: :report_reviewers_url, order: 1, if_can: 'index,report_reviewers'},
            {name: :denuncias, description: :denuncias, icon: :chat_bubble_at_mtl, url: :reports_url, order: 2, if_can: 'index,reports'},
          ]},
          {name: :messages, description: :messages, icon: :inbox_at_mtl, order: 2, plugins: [
            {name: :messages, description: :messages, icon: :inbox_at_mtl, url: :messages_url, order: 1, if_can: 'index,messages'},
          ]}
        ]},
        {name: :salary_managment, description: :salary_managment, icon: :view_comfy_at_mtl, order: 5, plugins: [
          {name: :salary_map, description: :salary_map, icon: :monetization_on_at_mtl, order: 1, url: :salaries_url, if_can: 'index,salaries'},
          {name: :remuneration_settings, description: :remuneration_settings, icon: :settings_at_mtl, url: :latest_remuneration_setting_url, order: 4, if_can: 'latest,remuneration_settings'}
        ]},
        {name: :time_managment, description: :time_managment, icon: :access_time_at_mtl, order: 6, plugins: [
          {name: :hr_presence_map, description: :hr_presence_map, icon: :access_time_at_mtl, url: :hr_presence_map_url, order: 0, if_can: 'hr_presence_map,employees'},
          {name: :department_presence_map, description: :department_presence_map, icon: :access_time_at_mtl, url: :department_presence_map_url, order: 0, if_can: 'department_presence_map,employees'},
          {name: :time_settings, description: :time_settings, icon: :settings_at_mtl, url: :latest_time_setting_url, order: 1, if_can: 'latest,time_settings'}
        ]},
        {name: :employee_self_service, description: :employee_self_service, icon: :person_outline_at_mtl, order: 7, plugins: [
          {name: :my_assessments, description: :my_assessments, icon: :view_list_at_mtl, url: :my_data_url, order: 1, if_can: 'my_data,employees'},
          {name: :my_orgchart, description: :my_orgchart, icon: :device_hub_at_mtl, url: :my_orgchart_url, order: 2, if_can: 'my_orgchart,positions'},
          {name: :my_training, description: :my_training, icon: :school_at_mtl, url: :my_training_url, order: 3, if_can: 'my_training,courses'},
          {name: :my_presence_map, description: :my_presence_map, icon: :access_time_at_mtl, url: :my_presence_map_url, order: 1, if_can: 'my_presence_map,employees'},
          {name: :comunication, description: :comunication, icon: :chat_bubble_outline_at_mtl, order: 4, plugins: [
            {name: :my_requests, description: :my_requests, icon: :chat_at_mtl, url: :my_requests_url, order: 3, if_can: 'my_requests,employees'},
            {name: :my_reports, description: :my_reports, icon: :chat_bubble_at_mtl, url: :my_reports_url, order: 4, if_can: 'my_reports,employees'},
            {name: :my_messages, description: :my_messages, icon: :inbox_at_mtl, url: :my_messages_url, order: 5, if_can: 'index,employee_messages'}
          ]}
        ]},
        {name: :manager_self_service, description: :manager_self_service, icon: :people_outline_at_mtl, order: 8, plugins: [
          {name: :my_team_assessment, description: :my_team_assessment, icon: :view_list_at_mtl, url: :my_team_assessment_url, order: 0, if_can: 'my_team_assessment,employees'},
          {name: :my_team_presence_map, description: :my_team_presence_map, icon: :access_time_at_mtl, url: :my_team_presence_map_url, order: 1, if_can: 'my_team_presence_map,employees'},
          {name: :my_team_orgchart, description: :my_team_orgchart, icon: :device_hub_at_mtl, url: :my_team_orgchart_url, order: 2, if_can: 'my_team_orgchart,positions'}
        ]},
        {name: 'plural.user', description: 'plural.user', icon: :group_add_at_mtl, url: :users_url, order: 9, if_can: 'index,users'},
        {name: 'plugins', description: 'plugins', icon: :view_quilt_at_mtl, url: :plugins_url, order: 10, if_can: 'index,plugins'}
    ]

    menus.each do |root|
      create_menu_item(root)
    end
  end

  def self.create_menu_item(root)
    plugins = root.delete(:plugins)
    plugin = Plugin.new(root)
    if plugin.save && plugins.present?
      p plugin
      plugins.each do |f|
        f[:parent_id] = plugin.id
        create_menu_item(f)
      end
    end
  end
end
