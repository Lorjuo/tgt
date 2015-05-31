# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
#set :output, "/path/to/my/cron_log.log"
set :environment, "development"
set :output, {:error => "log/cron_error_log.log", :standard => "log/cron_log.log"}

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

# Learn more: http://github.com/javan/whenever

# http://eewang.github.io/blog/2013/03/12/how-to-schedule-tasks-using-whenever/
every 1.hours do
  rake 'tgt:remove_unused_images'
end

# WHENEVER CHANGING THIS FILE - EXECUTE THE FOLLOWING COMMAND:
# whenever --update-crontab
# 
# CHECK CREATED CRONTABS WITH:
# crontab -l

# GENERAL CRON LOG:
# grep CRON /var/log/syslog