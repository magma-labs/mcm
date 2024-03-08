module Mcm
  class HeroImageComponent < BaseComponent
    def image_preview_styles
      # Matches the :large attachment variant in Asset
      "max-width:1920px;max-height:720px;"
    end

    def class_name
      "image_hero_#{@component.assets.first.id}"
    end

    def asset
      @component.assets.first
    end

    def height
      @component.parent.height
    end
  end
end
