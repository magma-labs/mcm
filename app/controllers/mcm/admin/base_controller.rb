# frozen_string_literal: true

module Mcm
  module Admin
    class BaseController < Mcm.admin_controller_parent.constantize
      layout Mcm.admin_layout if Mcm.admin_layout.present?

      before_action :set_admin_variant
      around_action :switch_locale

      def default_url_options
        super.merge locale: I18n.locale
      end

      private

      def switch_locale(&action)
        locale = params[:locale] || I18n.default_locale
        I18n.with_locale(locale, &action)
      end

      def set_admin_variant
        request.variant = :admin
      end
    end
  end
end
