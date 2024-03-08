module Mcm
  class HeroImageTitleContentCtaComponent < BaseComponent
    def content_alignment_classes
      [
        @component.metadata.content_vertical_alignment,
        @component.metadata.content_horizontal_alignment,
        @component.metadata.text_color
      ].join(' ')
    end
  end
end
