source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.1.1"
# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem "propshaft"

# Pogrest database
gem "pg"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"
# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"
# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"
# Use Tailwind CSS [https://github.com/rails/tailwindcss-rails]
gem "tailwindcss-rails"
# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Authentication
gem "devise"

# Delayed Job
gem "delayed_job_active_record"

gem 'daemons'

# Enumerize
gem "enumerize"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Use the database-backed adapters for Rails.cache, Active Job, and Action Cable
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Deploy this application anywhere as a Docker container [https://kamal-deploy.org]
gem "kamal", require: false

# Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster/]
gem "thruster", require: false

# Omniauth
gem "omniauth-google-oauth2"

gem 'httparty'

# --- Debugging Gems (Needed in both Development and Test) ---
group :development, :test do
  # Standard Ruby debugger (replacement for debug, byebug)
  # gem "debug", platforms: %i[ mri mingw x64_mingw ]

  # Pry/Byebug for advanced debugging (preferred over the standard debugger by some)
  gem "pry"
  gem "pry-byebug"
  gem "pry-remote"
  gem "pry-rails"

  # The original byebug on specific platforms
  gem "byebug", platforms: %i[mri mingw x64_mingw]
end

# --- Development and Static Analysis Gems ---
group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  gem "spring"

  # Console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Email interceptor for development
  gem "letter_opener"

  # Code analysis/styling tools
  gem "rubocop", require: false
  gem "rubocop-checkstyle_formatter", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-rails-omakase", require: false

  # Code intelligence
  gem "solargraph"

  # Deployment tools
  gem "capistrano"
  gem "capistrano-bundler"
  gem "capistrano-passenger"
  gem "capistrano-rails"
  gem "capistrano-rails-console", require: false
  gem "capistrano-rails-tail-log"
  gem "capistrano-rake", require: false
  gem "capistrano-rvm"

  # Utility
  gem "rack-cors" # for running everything local with ngrok
end

# --- Testing Gems (Only for `rails test` or `rspec` related tasks) ---
group :test do
  # RSpec testing framework
  gem "rspec-rails"

  # Factory for test data
  gem 'factory_bot_rails'
  gem 'faker'

  # System/Feature testing
  gem "capybara"
  gem "selenium-webdriver"

  # Tools for improving Capybara/System tests
  gem "capybara-screenshot"
  gem "database_cleaner-active_record"

  # HTTP/API testing
  gem "vcr"
  gem "webmock"

  # Performance and security testing
  gem "benchmark-memory"
  gem "brakeman", require: false

  # RSpec/Testing-specific RuboCop
  gem "rubocop-rspec", require: false

  # Output formats
  gem "rspec_junit_formatter", require: false

  # Controller testing
  gem 'rails-controller-testing'
end
