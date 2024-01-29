# frozen_string_literal: true

module Mcm
  class PagesController < ActionController::Base
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
