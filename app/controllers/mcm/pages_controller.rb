# frozen_string_literal: true

module Mcm
  class PagesController < Mcm.controller_parent.constantize
    layout Mcm.layout if Mcm.layout.present?

    def show
      @page = model_class.active.find_by!(path: request.path_info)
    end

    def preview
      @page = model_class.find_by(path: params[:path])
      render :show
    end

    private

    def model_class
      Mcm::Page
    end

    def page_params
      params.require(:page)
    end
  end
end
