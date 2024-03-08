module Mcm
  class SquareImageComponent < BaseComponent
    def positioning_classes
      [
        @component.metadata.vertical_alignment.presence,
        @component.metadata.horizontal_alignment.presence
      ].compact.join(' ')
    end
  end
end
