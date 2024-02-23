module Mcm
  class HeroSliderComponent < BaseComponent
    def self.component_type
      'container'
    end

    def image_styles
      "max-width:1920px;max-height:480px"
    end

    def full_width?
      object.metadata.full_width.eql?('1')
    end

    def defaults
      {
        height: 400,
        full_width: true
      }
    end
  end
end
