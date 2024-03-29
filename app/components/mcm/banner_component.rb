module Mcm
  class BannerComponent < BaseComponent
    def image_preview_styles(variant)
      case variant
      when :square
        "max-width:420px;max-height:630px;"
      when :banner
        "max-width:1920px;max-height:720px;"
      end
    end

    def variant_for(index)
      index.zero? ? :banner : :square
    end

    def background_image
      @component.assets.first&.attachment
    end

    def cta_image
      @component.assets.second&.attachment
    end
  end
end
