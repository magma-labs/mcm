require "spec_helper"

RSpec.describe Mcm::BannerComponent, type: :component do
  let(:component) do
    Mcm::ComponentsPage.create!(
      page: Mcm::Page.create!(name: "Test Page"),
      component: Mcm::Component.find_by!(name: "banner"),
      name: "Test component",
      position: 1,
      active: true,
      metadata: { content: "Foo Bar" },
      assets_attributes: [
        { attachment: fixture_file_upload("hero_image.png") },
        { attachment: fixture_file_upload("hero_image.png") }
      ]
    )
  end

  it_behaves_like "a component"
end
