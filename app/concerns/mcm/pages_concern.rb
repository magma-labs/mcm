module Mcm
  module PagesConcern
    extend ActiveSupport::Concern

    included do
      rescue_from ActiveRecord::RecordNotFound, with: :raise_page_not_found_error
    end

    def raise_page_not_found_error
      raise Mcm::PageNotFound
    end
  end
end
