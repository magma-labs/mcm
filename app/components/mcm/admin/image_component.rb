module Mcm::Admin
  class ImageComponent < BaseComponent
    def initialize(form:, styles:)
      @form = form
      @styles = styles
    end
  end
end
