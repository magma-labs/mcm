module Mcm
  class ColumnsComponent < FrontendComponent
    def self.component_type
      'container'
    end

    def full_width?
      @component.metadata.full_width.eql?('1')
    end

    def height
      @component.metadata.height.to_i.positive? ? "#{@component.metadata.height}px" : 'auto'
    end

    def title_classes
      metadata.values(:section_title_color, :section_title_alignment).join(' ')
    end
  end
end
