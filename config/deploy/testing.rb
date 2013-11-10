server "ubuntutest", :web, :app, :db, primary: true

set :application, "tgt"
set :user, "admin"
set :deploy_to, "/var/www/#{application}"
set :deploy_via, :remote_cache #:copy
set :copy_exclude, [ '.git' ]
set :use_sudo, true

set :scm, "git"
set :repository, "lorjuo@github.com/Lorjuo/#{application}"
set :branch, "develop"

set :rails_env, 'testing'