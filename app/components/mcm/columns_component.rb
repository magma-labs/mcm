module Mcm
  class ColumnsComponent < BaseComponent
    def self.component_type
      "container"
    end

    def full_width?
      @component.metadata.full_width.eql?('1')
    end

    def title_classes
      @component.metadata.values(:section_title_color, :section_title_alignment).join(' ')
    end
  end
end
