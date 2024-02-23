module Mcm
  class SquareImageComponent < BaseComponent
    def image_styles
      "max-width:680px;max-height:680px"
    end

    def backend_template
      'image_asset_with_positioning'
    end

    def positioning_classes
      [
        @component.metadata.vertical_alignment.presence,
        @component.metadata.horizontal_alignment.presence
      ].compact.join(' ')
    end
  end
end
