module Mcm
  class ImageComponent < BaseComponent
    def initialize(opts = {})
      %w[form styles label class_name height].each do |attribute|
        instance_variable_set "@#{attribute}", opts[attribute.to_sym]
      end

      @asset = opts[:asset] || @form&.object
      @variant = opts[:variant] || :desktop
    end

    protected

    def image_src
      return unless @asset.persisted?

      @asset.attachment.variant(@variant).processed.url
    end
  end
end
