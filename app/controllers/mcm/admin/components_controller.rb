# frozen_string_literal: true

module Mcm
  module Admin
    class ComponentsController < BaseController
      before_action :find_page
      before_action :find_component

      def create
        @component = if @component
          @component.children.create! component_params.merge(page: @page)
        else
          @page.components_pages.create! component_params
        end

        redirect_to main_app.edit_admin_custom_page_component_path(@page, @component)
      end

      def update
        @component.update! component_params

        redirect_to location_after_save
      end

      def destroy
        @component.destroy

        redirect_back fallback_location: location_after_save
      end

      def move_to
        @component.move_to(params[:position])

        redirect_back fallback_location: location_after_save
      end

      private

      def component_params
        params.require(:components_page).permit!
      end

      def find_page
        @page = Mcm::Page.find(params[:custom_page_id])
      end

      def find_component
        @component = @page.components_pages.where(id: params[:id] || params[:component_id]).first
      end

      def location_after_save
        if @component.children.any?
          main_app.admin_custom_page_component_path(@page, @component)
        elsif @component.parent
          main_app.admin_custom_page_component_path(@page, @component.parent)
        else
          main_app.admin_custom_page_path(@page)
        end
      end
    end
  end
end
