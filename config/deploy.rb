set :application, 'tgt'
set :repo_url, "git@github.com:Lorjuo/#{fetch(:application)}"
#set :repository, "http://USER:PASS@git.somewhere.tld"

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

#deploy_to has been switched to specific stages
set :deploy_to, "/var/www/#{fetch(:application)}" #{}"/home/#{fetch(:deploy_user)}/apps/#{fetch(:full_app_name)}"
set :scm, :git

set :format, :pretty
set :log_level, :debug
set :pty, true #default on
#set :use_sudo, true

# https://github.com/capistrano/capistrano/wiki/Using-SSH-Keys
# https://github.com/capistrano/capistrano/issues/666
set :ssh_options, {
  forward_agent: true,
#  verbose: :debug, # For debugging
  user: "deploy"
#  keys: %w(/home/julien/.ssh/id_rsa)
#   auth_methods: %w(password)
}
#set :scm_passphrase, "integer"

# setup rvm.
set :rbenv_type, :system
set :rbenv_ruby, '2.1.1' # maybe dash has to be deleted
set :rbenv_prefix, ""
#set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value

# set :default_env, {
#   'PATH' => "/usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH"
# }
# set :default_environment, {
#   :PATH => '$HOME/.rvm/gems/ruby-2.0.0-p353/bin:$PATH',
#   :GEM_HOME => '$HOME/.rvm/gems/ruby-2.0.0-p353',
#   :GEM_PATH => '$HOME/.rvm/gems/ruby-2.0.0-p353:$HOME/.rvm/gems/ruby-2.0.0-p353@global'
# }

set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

set :keep_releases, 5


# what specs should be run before deployment is allowed to
# continue, see lib/capistrano/tasks/run_tests.cap
set :tests, ["spec"]

# which config files should be copied by deploy:setup_config
# see documentation in lib/capistrano/tasks/setup_config.cap
# for details of operations
set(:config_files, %w(
  nginx.conf
  database.example.yml
  log_rotation
  monit
  unicorn.rb
  unicorn_init.sh
))
# TODO: add config.yml

# which config files should be made executable after copying
# by deploy:setup_config
set(:executable_config_files, %w(
  unicorn_init.sh
))

# files which need to be symlinked to other parts of the
# filesystem. For example nginx virtualhosts, log rotation
# init scripts etc.
set(:symlinks, [
  {
    source: "nginx.conf",
    link: "/etc/nginx/sites-enabled/#{fetch(:application)}" #full_app_name
  },
  {
    source: "unicorn_init.sh",
    link: "/etc/init.d/unicorn_#{fetch(:application)}" #full_app_name
  },
  {
    source: "log_rotation",
    link: "/etc/logrotate.d/#{fetch(:application)}" #full_app_name
  },
  {
    source: "monit",
    link: "/etc/monit/conf.d/#{fetch(:application)}.conf" #full_app_name
  }
])


# this:
# http://www.capistranorb.com/documentation/getting-started/flow/
# is worth reading for a quick overview of what tasks are called
# and when for `cap stage deploy`

namespace :deploy do
  # make sure we're deploying what we think we're deploying
  before :deploy, "deploy:check_revision"
  # only allow a deploy with passing tests to deployed
  # before :deploy, "deploy:run_tests"
  # compile assets locally then rsync
  after 'deploy:symlink:shared', 'deploy:compile_assets_locally'
  after :finishing, 'deploy:cleanup'
  
  task :whoami do
    on roles(:all) do
      execute :whoami
    end
  end
end