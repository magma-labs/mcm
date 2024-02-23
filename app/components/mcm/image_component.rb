module Mcm
  class ImageComponent < BaseComponent
    def initialize(form:, styles:, variant: :desktop, label: nil)
      @form = form
      @styles = styles
      @variant = variant
      @label = label
    end

    protected

    def image_src
      return unless @form.object.persisted?

      @form.object.attachment.variant(@variant).processed.url
    end
  end
end
