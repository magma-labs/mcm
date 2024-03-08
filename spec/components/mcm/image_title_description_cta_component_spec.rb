require "spec_helper"

RSpec.describe Mcm::ImageTitleDescriptionCtaComponent, type: :component do
  let(:component) do
    Mcm::ComponentsPage.create!(
      page: Mcm::Page.create!(name: "Test Page"),
      component: Mcm::Component.find_by!(name: "image_title_description_cta"),
      name: "Test component",
      position: 1,
      active: true,
      metadata: { title: "Section 1" },
      assets_attributes: [
        { attachment: fixture_file_upload("hero_image.png") }
      ]
    )
  end

  it_behaves_like "a component"
 end
