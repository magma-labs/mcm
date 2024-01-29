# frozen_string_literal: true

ENV["RAILS_ENV"] = "test"

# Create the dummy app if it's not there already.
dummy_env = "#{__dir__}/dummy/config/environment.rb"
system 'bundle exec rake dummy:setup' unless File.exist? dummy_env
require dummy_env

# Load the rails environment
require "#{__dir__}/dummy/config/environment"
require "rspec/rails"

RSpec.configure do |config|
  config.order = "random"
  config.use_transactional_fixtures = true
end
