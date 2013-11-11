require "bundler/capistrano"

set :stages, %w(production testing)
set :default_stage, "production"
require 'capistrano/ext/multistage'

# set :rake, "#{rake} --trace"
set :bundle_flags, "--quiet" #"--deployment"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true


#reb: turned off, due to not working most of the time

#after "deploy", "deploy:cleanup" # keep only the last 5 releases

set :rvm_ruby_string, :local
set :rvm_autolibs_flag, "read-only"

before 'deploy:setup', 'rvm:install_rvm'
before 'deploy:setup', 'rvm:install_ruby'

require 'rvm/capistrano'

# Uploaded Files
# http://astonj.com/tech/how-to-get-capistrano-to-ignore-upload-directories-carrierwave/
# http://stackoverflow.com/questions/9043662/carrierwave-files-with-capistrano
set :shared_children, shared_children + %w{public/uploads public/files}

namespace :deploy do

  task :setup_config, roles: :app do
    puts "current_path: #{current_path}"
    sudo "ln -nfs #{current_path}/config/apache.#{fetch :rails_env}.conf /etc/apache2/sites-available/#{application}"
    run "mkdir -p /var/www/sites"
    sudo "ln -nfs /var/www/#{application}/current/public/ /var/www/sites/#{application}"
    run "mkdir -p #{shared_path}/config"
    run "mkdir -p #{shared_path}/cached-copy"
    put File.read("config/database.#{fetch :rails_env}.yml"), "#{shared_path}/config/database.yml"
    puts "Now edit the config files in #{shared_path}."
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  # desc "Make sure local git is in sync with remote."
  # task :check_revision, roles: :web do
  #   unless `git rev-parse HEAD` == `git rev-parse origin/master`
  #     puts "WARNING: HEAD is not the same as origin/master"
  #     puts "Run `git push` to sync changes."
  #     exit
  #   end
  # end
  #before "deploy", "deploy:check_revision"
end