# frozen_string_literal: true

# ================================
# Capistrano configuration
# ================================
lock "~> 3.19.2"

set :application, "scraper"
set :repo_url, "git@github.com:sokmesakhiev/scraper.git"

# ================================
# Deployment settings
# ================================
set :deploy_to, "/var/www/rails_app"
set :deploy_via, :remote_cache
set :keep_releases, 5

# ================================
# Output / Logging
# ================================
set :format, :airbrussh
set :format_options,
    command_output: true,
    log_file: "log/capistrano.log",
    color: :auto,
    truncate: :auto

set :pty, true

# ================================
# Ruby environment
# ================================
set :rbenv_type, :user
set :rbenv_ruby, "3.4.5" # adjust to your version
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w[rake gem bundle ruby rails]

# ================================
# Shared directories and files
# ================================
append :linked_dirs,
       "log",
       "tmp/pids",
       "tmp/cache",
       "tmp/sockets",
       "tmp/files",
       "public/system",
       "public/images/production",
       "public/images",
       "public/javascripts",
       "public/stylesheets"

# ================================
# Passenger setup
# ================================
set :passenger_restart_with_touch, true

# ================================
# Custom tasks
# ================================
namespace :deploy do
  desc "Upload Rails credentials production key"
  task :upload_credentials_key do
    on roles(:app) do
      shared_key_path = "#{shared_path}/production.key"
      release_key_path = "#{release_path}/config/credentials/production.key"

      # Ensure destination directory exists
      execute :mkdir, "-p", "#{release_path}/config/credentials"

      # Copy key into release path
      execute :cp, shared_key_path, release_key_path

      # Secure permissions
      execute :chmod, "600", release_key_path
    end
  end

  desc "Restart application (Passenger)"
  task :restart do
    on roles(:app) do
      execute :touch, release_path.join("tmp/restart.txt")
    end
  end

  # Hooks
  before "deploy:assets:precompile", "deploy:upload_credentials_key"
  after :publishing, :restart
end
