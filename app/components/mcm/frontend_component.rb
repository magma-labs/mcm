module Mcm
  class FrontendComponent < ::ViewComponent::Base
    def initialize(component:)
      @component = component
    end
  end
end
