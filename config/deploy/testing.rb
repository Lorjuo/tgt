server "ubuntutest", :web, :app, :db, primary: true

set :application, "tgt"
set :user, "julien"
set :deploy_to, "/var/www/#{application}"
set :deploy_via, :copy
# set :deploy_via, :remote_cache
# set :copy_exclude, [ '.git' ]
set :use_sudo, true

set :scm, "git"
set :repository, "git@github.com:Lorjuo/#{application}"
set :branch, "develop"

set :rails_env, 'testing'