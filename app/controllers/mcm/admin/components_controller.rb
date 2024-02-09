# frozen_string_literal: true

module Mcm
  module Admin
    class ComponentsController < BaseController
      before_action :find_page, only: [:new, :create]
      before_action :find_parent, only: [:new, :create]
      before_action :find_component, except: [:new, :create]

      def create
        @component = if @parent
          model_class.create! component_params.merge(parent: @parent, page_id: @parent.page_id)
        else
          @page.components_pages.create! component_params
        end

        redirect_to main_app.edit_admin_component_path(@component)
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
        return unless params[:page_id]

        @page = Mcm::Page.find params[:page_id]
      end

      def find_parent
        return unless params[:parent_id]

        @parent = model_class.find params[:parent_id]
      end

      def find_component
        @component = model_class.find params[:id]
      end

      def model_class
        Mcm::ComponentsPage
      end

      def location_after_save
        if @component.children.any?
          main_app.admin_component_path(@component)
        elsif @component.parent
          main_app.admin_component_path(@component.parent)
        else
          main_app.admin_custom_page_path(@component.page)
        end
      end
        end
      end
    end
  end
end
