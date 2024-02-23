module Mcm
  class RichTextComponent < BaseComponent
    def content_classes
      [
        'my-3',
        @component.metadata.body_color
      ].join(' ')
    end
  end
end
