require 'rubygems'

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

require 'shoulda-matchers'
require 'clearance/testing/helpers'
require 'draper/test/rspec_integration'
require 'chewy/rspec'
require 'sidekiq/testing'
require 'capybara/email/rspec'

require 'spec_helper'

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include Clearance::Testing::Helpers
end

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
#
# Duplication here is to enforce the correct order.
Dir[Rails.root.join("spec/support/features/**/*.rb")].each { |f| require f }
Dir[Rails.root.join("spec/support/requests/**/*.rb")].each { |f| require f }
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

Sidekiq::Testing.inline!

Capybara.javascript_driver = :selenium
