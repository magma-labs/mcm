module Mcm
  class BaseComponent < ::ViewComponent::Base
    def initialize(component:, component_form: nil)
      @component = component
      @component_form = component_form
    end

    protected

    def image_preview_styles
      # Matches the :small attachment variant in Asset
      "max-width:400px;max-height:400px;"
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
