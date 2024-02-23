require_relative "lib/mcm/version"

Gem::Specification.new do |spec|
  spec.name        = "mcm"
  spec.version     = Mcm::VERSION
  spec.authors     = ["Kevin Perez"]
  spec.email       = ["kevin.perez@magmalabs.io"]
  spec.homepage    = "https://mcm.com"
  spec.summary     = " Summary of Mcm."
  spec.description = " Description of Mcm."
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = " Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://mcm.com"
  spec.metadata["changelog_uri"] = "https://mcm.com"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 6.0.0"
  spec.add_dependency "haml-rails"
  spec.add_dependency "image_processing", "~> 1.2"
  spec.add_dependency "bootstrap_form", "~> 4.0"
  spec.add_dependency "activestorage", ">= 6.0.0"
  spec.add_dependency "view_component", ">= 2.7.0"
end
