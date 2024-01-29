# frozen_string_literal: true

module Mcm
  module Admin
    class CustomPagesController < ActionController::Base
      before_action :find_page, only: [:show, :update, :destroy]

      def index
        @custom_pages = model_class.all
      end

      def create
        @page = model_class.create! custom_page_params
        redirect_to location_after_save
      end

      def update
        @page.update! custom_page_params
        redirect_to location_after_save
      end

      def destroy
        @page.destroy
        redirect_to admin_custom_pages_path
      end

      private

      def find_page
        @page = model_class.find params[:id]
      end

      def model_class
        Mcm::Page
      end

      def custom_page_params
        params.require(:page).permit :name, :path, :metadata, :active
      end

      def location_after_save
        request.headers['Referer'].presence || admin_custom_page_path(@page)
      end
    end
  end
end
