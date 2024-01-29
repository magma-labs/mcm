require "fileutils"
require "rails/generators"
require "rails/generators/rails/app/app_generator"

class DummyAppGenerator < Rails::Generators::Base
  def name
    "dummy"
  end

  def engine
    "mcm"
  end

  def spec_path
    "#{__dir__}/../spec"
  end

  def destination_path
    File.join(spec_path, name)
  end

  def run!
    puts "Generating dummy app..."
    FileUtils.chdir spec_path do
      Rails::Generators::AppGenerator.start([name, "--skip_bootsnap"])
    end
    FileUtils.chdir destination_path do
      run "rake mcm:install:migrations"
      run "rake db:create db:migrate"
    end
  end
end
