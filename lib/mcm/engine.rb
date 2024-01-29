module Mcm
  class Engine < ::Rails::Engine
    engine_name 'mcm'
    isolate_namespace Mcm

    config.assets.precompile += %w( mcm_manifest.js ) if config.respond_to?(:assets)

    initializer "mcm.importmap", before: "importmap" do |app|
      app.config.importmap.paths << Engine.root.join("config/importmap.rb") if app.config.respond_to?(:importmap)
    end
  end
end
