# frozen_string_literal: true

module Mcm
  class PagesController < Mcm.controller_parent.constantize
    include Mcm::PagesConcern

    layout Mcm.layout if Mcm.layout.present?

    def show
      @page = model_class.find_by_route(request.path_info).first!
    end

    private

    def model_class
      Mcm::Page
    end
  end
end
