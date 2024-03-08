module Mcm
  class Engine < ::Rails::Engine
    engine_name 'mcm'
    isolate_namespace Mcm

    initializer "mcm.assets" do |app|
      app.config.assets.precompile += %w[mcm_manifest]
    end

    initializer "mcm.importmap", before: "importmap" do |app|
      app.config.importmap.paths << Engine.root.join("config/importmap.rb")
    end
  end
end
