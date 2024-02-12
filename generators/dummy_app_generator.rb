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
    Dir.chdir spec_path do
      Rails::Generators::AppGenerator.start([name, "--skip_bootsnap"])
    end

    Dir.chdir destination_path do
      append_to_file "#{destination_path}/Gemfile", 'gem "mcm", path: "../.."'

      insert_into_file "#{destination_path}/config/routes.rb", after: "Rails.application.routes.draw do" do
        "\n  mount Mcm::Engine, at: '/'"
      end

      create_file "#{destination_path}/config/initializers/mcm.rb", <<~EOF
        Mcm.controller_parent = "ApplicationController"
        Mcm.admin_controller_parent = "ApplicationController"
      EOF

      run "rake active_storage:install:migrations"
      run "rake mcm:install:migrations"

      run "RAILS_ENV=test rake db:create db:migrate"
      run "RAILS_ENV=development rake db:create db:migrate mcm:sync_components"

      insert_into_file "#{destination_path}/app/views/layouts/application.html.erb", after: "<%= csp_meta_tag %>" do
        <<~EOF
          \n<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" />
          <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
          <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"></script>
          <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"></script>
        EOF
      end
    end
  end
end
