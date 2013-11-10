server "ubuntuprod", :web, :app, :db, primary: true

set :application, "tgt-refurbished"
set :user, "admin"
set :deploy_to, "/var/www/#{application}"
set :deploy_via, :remote_cache #:copy
set :copy_exclude, [ '.git' ]
set :use_sudo, true

set :scm, "git"
set :repository, "lorjuo@github.com/Lorjuo/#{application}"
set :branch, "master"

set :rails_env, 'production'