# frozen_string_literal: true

# config valid for current version and patch releases of Capistrano
lock "~> 3.19.2"

set :application, "scraper"
set :repo_url, "ssh://git@github.com:sokmesakhiev/scraper.git"

set :stages, %w[production]

set :deploy_via, :remote_cache
# set :scm, 'git'

set :format, :airbrussh
set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

set :pty, true

set :passenger_restart_with_touch, true

# Configuration files that must be present in the shared directory
# set :linked_files, fetch(:linked_files, []).concat(%w[config/database.yml config/secrets.yml .env])

# append :linked_files, 'config/application.yml'
append :linked_dirs, "log", "tmp/git_cli", "tmp/pids", "tmp/cache", "tmp/sockets", "tmp/files", "public/system", "public/images/production", "public/images", "public/javascripts", "public/stylesheets"

set :keep_releases, 5
set :rvm_type, :user

# after 'deploy:publishing', 'queues:restart'
