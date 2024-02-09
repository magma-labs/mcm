# frozen_string_literal: true

ENV["RAILS_ENV"] = "test"

require "silent_stream"
include SilentStream

# Create the dummy app if it's not there already.
dummy_env = "#{__dir__}/dummy/config/environment.rb"
unless File.exist? dummy_env
  puts "Building dummy app..."
  quietly { system 'bundle exec rake dummy:setup' }
end

# Load the rails environment
require dummy_env
require "#{__dir__}/dummy/config/environment"
require "rspec/rails"

# Configure mcm
Mcm.controller_parent = "ActionController::Base"
Mcm.admin_controller_parent = "ActionController::Base"

# Configure rspec
RSpec.configure do |config|
  config.include SilentStream

  config.order = "random"
  config.use_transactional_fixtures = true

  # Sync components
  config.before :all do
    Rails.application.load_tasks
    silence_stream(STDOUT) { Rake::Task['mcm:sync_components'].invoke }
  end
end
