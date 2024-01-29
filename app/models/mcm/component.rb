# frozen_string_literal: true

module Mcm
  class Component < Mcm::ApplicationRecord
    has_many :component_pages, class_name: 'Mcm::ComponentsPage', dependent: :destroy

    validates :name, :component_type, presence: true

    scope :containers, -> { where(component_type: 'container') }
    scope :content, -> { where(component_type: 'content') }
  end
end
