#!/usr/bin/env puma
# Needs to be copied to: /var/www/tgt/shared/config/puma.rb

environment 'production'
threads 2, 16
workers 4

app_name = "tgt"
application_path = "/var/www/#{app_name}"
directory "#{application_path}/current"

pidfile "#{application_path}/shared/tmp/pids/puma.pid"
state_path "#{application_path}/shared/tmp/sockets/puma.state"
stdout_redirect "#{application_path}/shared/log/puma.stdout.log", "#{application_path}/shared/log/puma.stderr.log", true # true for appending
#bind "unix://#{application_path}/shared/tmp/sockets/#{app_name}.sock"
bind "unix://#{application_path}/shared/tmp/sockets/puma.sock"
activate_control_app "unix://#{application_path}/shared/tmp/sockets/pumactl.sock"

daemonize true
on_restart do
  puts 'On restart...'
end
#preload_app!