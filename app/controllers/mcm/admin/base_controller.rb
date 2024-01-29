# frozen_string_literal: true

module Mcm
  module Admin
    class BaseController < ActionController::Base
      layout Mcm.admin_layout if Mcm.admin_layout.present?
    end
  end
end
