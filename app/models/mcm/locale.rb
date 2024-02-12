module Mcm
  class Locale < ApplicationRecord
    ROUTE_REGEXP = %r{\A/[/[a-z0-9-]*]*\z}.freeze

    belongs_to :localizable, polymorphic: true

    validates_presence_of :locale, :key, :value, :localizable
    validates :value, uniqueness: true, format: { with: ROUTE_REGEXP, message: I18n.t('custom_pages.pages.slug_error') }, if: :route?

    scope :routes, ->{ where(key: 'route') }

    def route?
      key == 'route'
    end
  end
end
