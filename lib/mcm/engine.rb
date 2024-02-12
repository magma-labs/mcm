module Mcm
  class Engine < ::Rails::Engine
    engine_name 'mcm'
    isolate_namespace Mcm

    initializer "mcm.assets" do |app|
      app.config.assets.precompile += %w[mcm_manifest]
    end
  end
end
