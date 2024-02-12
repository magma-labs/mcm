# frozen_string_literal: true

module Mcm
  class Page < Mcm::ApplicationRecord
    has_many :components_pages, -> { non_draft }, class_name: 'Mcm::ComponentsPage', dependent: :destroy
    has_many :components, class_name: 'Mcm::Component', through: :components_pages
    has_many :routes, ->{ routes }, class_name: 'Mcm::Locale', as: :localizable

    validates :name, presence: true

    scope :active, -> { where(active: true) }

    serialize :metadata, coder: Mcm::JsonSerializer

    def self.find_by_route(route)
      includes(:routes).active.where(routes: { value: route })
    end

    def disabled?
      !active
    end
  end
end
