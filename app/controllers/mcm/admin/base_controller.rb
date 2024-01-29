# frozen_string_literal: true

module Mcm
  module Admin
    class BaseController < Mcm.admin_controller_parent.constantize
      layout Mcm.admin_layout if Mcm.admin_layout.present?
    end
  end
end
