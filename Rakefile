require "bundler/setup"
require "bundler/gem_tasks"
require_relative "generators/dummy_app_generator"

namespace :dummy do
  desc "Generate dummy app for specs"
  task :setup do
    Rake::Task["dummy:remove"].invoke
    DummyAppGenerator.new.run!
  end

  desc "Remove dummy app"
  task :remove do
    FileUtils.rm_r Dir.glob('spec/dummy/')
  end
end
