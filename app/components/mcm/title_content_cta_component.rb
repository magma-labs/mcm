module Mcm
  class TitleContentCtaComponent < BaseComponent
    def component_classes
      @component.metadata
                .values(:content_vertical_alignment, :content_horizontal_alignment)
                .join(' ')
    end

    def title_classes
      @component.metadata.values(:title_color, :title_alignment).join(' ')
    end

    def content_classes
      (%w[my-3] + @component.metadata.values(:content_color, :content_alignment)).join(' ')
    end
  end
end
