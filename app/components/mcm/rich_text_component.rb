module Mcm
  class RichTextComponent < FrontendComponent
    def content_classes
      [
        'my-3',
        @component.metadata.body_color
      ].join(' ')
    end
  end
end
