# frozen_string_literal: true

module Mcm
  class TitleContentCtaPresenter < ComponentsBasePresenter
    def self.content_type
      'component'
    end

    def component_classes
      metadata
          .values(:content_vertical_alignment, :content_horizontal_alignment)
          .join(' ')
    end
  end
end
