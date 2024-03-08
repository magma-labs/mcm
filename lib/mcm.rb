require "view_component"
require "haml-rails"
require "bootstrap_form"
require "mcm/version"
require "mcm/engine"
require "mcm/railtie"
require "mcm/custom_hash"
require "mcm/json_serializer"

module Mcm
  mattr_accessor :layout, :admin_layout, :controller_parent, :admin_controller_parent
end
