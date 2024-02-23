module Mcm
  class ImageComponent < BaseComponent
    def initialize(form:, styles:, variant: :desktop)
      @form = form
      @styles = styles
      @variant = variant
    end

    protected

    def image_src
      return unless @form.object.persisted?

      @form.object.attachment.variant(@variant).processed.url
    end
  end
end
