module Mcm::Admin
  class ImageComponent < FormComponent
    def initialize(form:, styles:)
      @form = form
      @styles = styles
    end
  end
end
