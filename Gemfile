source 'https://rubygems.org'

gem 'rails', '~> 4.1'

# Environment vars and configs
gem 'dotenv-rails'
gem 'dotenv-deployment'

# db
gem 'pg'

# Queuing
gem 'sinatra'
gem 'sidekiq'

# Layout and view
gem 'bootstrap-sass'
gem 'font-awesome-rails'
gem 'bootstrap-glyphicons'
gem 'haml-rails'
gem 'simple_form'
gem 'kaminari'
gem 'redcarpet', '~> 3.0.0'

# State
gem 'finite_machine'

# Voting
gem 'acts_as_votable', '~> 0.10.0'

# Tags
gem 'acts-as-taggable-on'

# Search
gem 'chewy'
gem 'elasticsearch-model'
gem 'elasticsearch-rails'

# AM Interfaces
gem 'virtus'

# I18n
gem 'rails-i18n', '~> 4.0.0' # For 4.0.x

# CSS
gem 'sass-rails', '~> 4.0.0'

# JS
gem 'momentjs-rails', '>= 2.8.1'
gem 'bootstrap3-datetimepicker-rails', '~> 3.1.2'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'sprockets-coffee-react'
gem 'therubyracer'
gem 'jquery-rails'
gem 'react-rails', '~> 0.11'
gem 'jquery-minicolors-rails'
gem 'tagmanager-rails'
gem 'twitter-typeahead-rails'
gem 'showdown-rails'
gem 'rails-bootstrap-markdown'

# Data formatting
gem "active_model_serializers", '0.8.1'
gem 'draper'

# Use ActiveModel has_secure_password
gem 'bcrypt'

# Auth
gem 'clearance'
gem 'doorkeeper'
gem 'rack-cors', :require => 'rack/cors'

group :development do
  gem 'transpec'
  gem 'quiet_assets'

  # Deploy
  gem 'capistrano'
  gem 'capistrano-rails', '~> 1.1'
  gem 'capistrano-ssh-doctor'

  # Profile
  gem 'rack-mini-profiler'

  # Better error messages
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :development, :test do
  # Data
  gem 'ffaker'

  # Specs
  gem 'rspec-rails', '~> 3'
  gem 'fuubar'                 # Pretty spec formatting
  gem 'letter_opener'          # Opens sent emails in browser

  # Automation
  gem "guard"
  gem "guard-bundler"
  gem "guard-livereload"
  gem "guard-migrate"
  gem "guard-rails"
  gem "guard-spring"
  gem "guard-pow"
  gem "rb-fchange", require: false
  gem "rb-fsevent", require: false
  gem "rb-inotify", require: false
  gem "spring"
  gem "spring-commands-rspec"
end

group :test do
  gem 'shoulda'
  gem 'factory_girl_rails'
  gem 'timecop'
  gem 'webmock'
  gem 'selenium-webdriver'
  gem 'capybara-email'
  gem 'database_cleaner'
  gem 'guard-rspec'
  gem 'guard-brakeman'
  gem 'vcr'
  gem 'oauth2'
end
