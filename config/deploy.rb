# config valid for current version and patch releases of Capistrano
lock "~> 3.10.0"

set :application, "nextbss"
# url SSH
set :repo_url, "nextbss@vs-ssh.visualstudio.com:22/erp_bancosol/_ssh/bancosol"

# url HTTPS
#set :repo_url, "http://nextbss.visualstudio.com:80/pluralia/_git/bancosol"
#set :repo_url, "https://nextbss.visualstudio.com/pluralia/_git/bancosol"

#set :git_https_username, 'sysdeploy'
#set :git_https_password, 'WeDeployNow2018'
# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/home/deploy/nextbss'
set :deploy_to, '/home/administrador/nextbss'

# deploy config
set :user, "sysdeploy"
set :pty, true

append :linked_files, "config/database.yml", "config/secrets.yml"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "vendor/bundle", "public/system", "public/uploads"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 1

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
