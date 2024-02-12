# frozen_string_literal: true

module Mcm
  module Admin
    module LocalesHelper
      def localizable_path
        case @locale.localizable_type
        when 'Mcm::Page'
          main_app.admin_custom_page_path(@locale.localizable_id)
        when 'Mcm::ComponentPage'
          main_app.admin_component_page_path(@locale.localizable_id)
        end
      end
    end
  end
end
