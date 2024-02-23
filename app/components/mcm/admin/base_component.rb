# frozen_string_literal: true

module Mcm::Admin
  class BaseComponent < ::ViewComponent::Base
    attr_reader :component, :form, :component_form

    def initialize(component:, component_form:)
      @component = component
      @component_form = component_form
    end

    protected

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

    def available_button_colors
      {
        I18n.t('custom_pages.color.white') => "text-white",
        I18n.t('custom_pages.color.dark') => "text-dark",
        I18n.t('custom_pages.color.primary') => "text-primary",
        I18n.t('custom_pages.color.secondary') => "text-secondary"
      }
    end
  end
end
