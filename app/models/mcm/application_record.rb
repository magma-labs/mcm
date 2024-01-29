# frozen_string_literal: true

module Mcm
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
    self.table_name_prefix = 'mcm_'
  end
end
