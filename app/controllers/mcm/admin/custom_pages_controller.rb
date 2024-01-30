# frozen_string_literal: true

module Mcm
  module Admin
    class CustomPagesController < BaseController
      before_action :find_page, except: [:index, :new, :create]

      def index
        @custom_pages = model_class.all
      end

      def create
        @page = model_class.create! custom_page_params
        redirect_to main_app.admin_custom_page_path(@page)
      end

      def update
        @page.update! custom_page_params
        redirect_to main_app.admin_custom_page_path(@page)
      end

      def destroy
        @page.destroy
        redirect_to main_app.admin_custom_pages_path
      end

      private

      def find_page
        @page = model_class.find params[:id]
      end

      def model_class
        Mcm::Page
      end

      def custom_page_params
        params.require(:page).permit :name, :path, :active, metadata: [
          :background_color,
          :meta_description,
          :meta_keywords
        ]
      end
    end
  end
end
