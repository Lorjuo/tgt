#! /bin/sh

PUMA_CONFIG_FILE=/var/www/myapp/current/config/puma.rb
PUMA_PID_FILE=/var/www/myapp/shared/tmp/pids/puma.pid
PUMA_SOCKET=/var/www/myapp/shared/tmp/sockets/puma.sock

# check if puma process is running
puma_is_running() {
  if [ -S $PUMA_SOCKET ] ; then
    if [ -e $PUMA_PID_FILE ] ; then
      if cat $PUMA_PID_FILE | xargs pgrep -P > /dev/null ; then
        return 0
      else
        echo "No puma process found"
      fi
    else
      echo "No puma pid file found"
    fi
  else
    echo "No puma socket found"
  fi

  return 1
}

case "$1" in
  