#!/usr/bin/env puma

environment ENV['RAILS_ENV'] || 'production'

daemonize true

pidfile "/var/www/tgt/shared/tmp/pids/puma.pid"
stdout_redirect "/var/www/tgt/shared/tmp/log/stdout", "/var/www/tgt/shared/tmp/log/stderr"

threads 0, 16

bind "unix:///var/www/tgt/shared/tmp/sockets/puma.sock"