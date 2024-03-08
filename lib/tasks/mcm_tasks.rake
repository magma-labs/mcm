namespace :mcm do
  task sync_components: :environment do
    components = []
    path = File.join(File.dirname(__FILE__), '..', '..', 'app', 'components', 'mcm', '*.rb')
    Dir[path].each do |file|
      component_name = file.split('/').last.gsub('_component.rb', '')
      next if %w[base image].include?(component_name)

      puts "Syncing #{component_name}"
      component = "Mcm::#{component_name.camelize}Component".constantize
      Mcm::Component.find_or_create_by(name: component_name,component_type: component.component_type)
      components << component_name
    end
    Mcm::Component.where.not(name: components).destroy_all
  end
end
