# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end
# set :environment, 'development'

every :month, at: '05:00' do
  rake "time:creates_vacation_year"
  rake "time:increment_vacation"
end

every :day, at: '05:00' do
  rake "employee_absences:self_register"
end

every :day, at: '07:00' do
  rake "access:change_or_update_access"
end

# Learn more: http://github.com/javan/whenever
