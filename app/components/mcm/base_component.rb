module Mcm
  class BaseComponent < ::ViewComponent::Base
    def self.component_type
      "content"
    end

    def initialize(component:)
      @component = component
    end

    def defaults
      {}
    end

    def image_preview_styles
      # Matches the :small attachment variant in Asset
      "max-width:400px;max-height:400px;"
    end

    def height
      @component.metadata.height.to_i.positive? ? "#{@component.metadata.height}px" : 'auto'
    end

    def background_color
      @component.metadata.background_color
    end

    def title_classes
      @component.metadata.values(:title_color, :title_alignment).join(' ')
    end

    def content_classes
      (%w[my-3] + @component.metadata.values(:content_color, :content_alignment)).join(' ')
    end

    def text_alignments
      {
        I18n.t('custom_pages.alignment.left') => "text-left",
        I18n.t('custom_pages.alignment.center') => "text-center",
        I18n.t('custom_pages.alignment.right') => "text-right",
        I18n.t('custom_pages.alignment.justify') => "text-justify"
      }
    end

    def vertical_alignment_options
      {
        I18n.t('custom_pages.alignment.start') => "align-items-start",
        I18n.t('custom_pages.alignment.center') => "align-items-center",
        I18n.t('custom_pages.alignment.end') => "align-items-end"
      }
    end

    def horizontal_alignment_options
      {
        I18n.t('custom_pages.alignment.start') => "justify-content-start",
        I18n.t('custom_pages.alignment.center') => "justify-content-center",
        I18n.t('custom_pages.alignment.end') => "justify-content-end"
      }
    end

    def available_text_colors
      {
        I18n.t('custom_pages.color.white') => "text-white",
        I18n.t('custom_pages.color.dark') => "text-dark",
        I18n.t('custom_pages.color.primary') => "text-primary",
        I18n.t('custom_pages.color.secondary') => "text-secondary"
      }
    end

    def available_button_colors
      {
        I18n.t('custom_pages.color.white') => "btn-white",
        I18n.t('custom_pages.color.dark') => "btn-dark",
        I18n.t('custom_pages.color.primary') => "btn-primary",
        I18n.t('custom_pages.color.secondary') => "btn-secondary"
      }
    end
  end
end
