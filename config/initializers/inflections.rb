# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format. Inflections
# are locale specific, and you may define rules for as many different
# locales as you wish. All of these examples are active by default:
 ActiveSupport::Inflector.inflections(:en) do |inflect|
  #inflect.plural /^(ox)$/i, '\1en'
  #inflect.singular /^(ox)en/i, '\1'
  #inflect.irregular 'person', 'people'
  inflect.irregular 'configuration', 'configurations'
  inflect.irregular 'plugin', 'plugins'
  inflect.irregular 'roles_mask', 'roles_masks'
  inflect.irregular 'setting', 'settings'
  inflect.irregular 'activity', 'activities'
  inflect.irregular 'employee_assessment', 'employees_assessments'
  inflect.irregular 'notification', 'notifications'
  inflect.irregular 'notification_employee', 'notifications_employee'

  inflect.irregular 'general_goal', 'general_goals'
  inflect.irregular 'team_goal', 'team_goals'
  inflect.irregular 'corporate_goal', 'corporate_goals'
  inflect.irregular 'individual_goal', 'individual_goals'


   #inflect.uncountable %w( fish sheep )
 end

# These inflection rules are supported but not enabled by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.acronym 'RESTful'
# end
