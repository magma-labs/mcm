module Mcm
  class Asset < ApplicationRecord
    belongs_to :components_page, class_name: 'Mcm::ComponentsPage'
    has_one_attached :attachment do |attachable|
      attachable.variant :mobile, resize_to_limit: [420, 435]
      attachable.variant :tablet, resize_to_limit: [740, 435]
      attachable.variant :desktop, resize_to_limit: [1200, 430]
      attachable.variant :small, resize_to_limit: [400, 400]
      attachable.variant :large, resize_to_limit: [1920, 720]
      attachable.variant :banner, resize_to_limit: [1920, 720]
      attachable.variant :square, resize_to_limit: [420, 630]
    end

    delegate :url, to: :attachment

    default_scope -> { order(:position) }

    before_create :calculate_position

    private

    def calculate_position
      self.position = (components_page.assets.last&.position.presence || 0) + 1
    end
  end
end
