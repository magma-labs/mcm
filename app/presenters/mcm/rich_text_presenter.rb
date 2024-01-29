# frozen_string_literal: true

module Mcm
  class RichTextPresenter < ComponentsBasePresenter
    def content_classes
      [
          'my-3',
          object.metadata.body_color
      ].join(' ')
    end
  end
end
