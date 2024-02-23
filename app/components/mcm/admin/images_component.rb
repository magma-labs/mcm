module Mcm::Admin
  class ImagesComponent < BaseComponent
    haml_template <<~HAML
      - component_form.fields_for :assets do |assets_form|
        = render Mcm::Admin::ImageComponent.new(form: assets_form, styles: image_styles)
    HAML
  end
end
