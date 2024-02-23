module Mcm::Admin
  class RichTextComponent < BaseComponent
    def content_classes
      [
          'my-3',
          object.metadata.body_color
      ].join(' ')
    end
  end
end
