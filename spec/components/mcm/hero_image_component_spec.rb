require "spec_helper"

RSpec.describe Mcm::HeroImageComponent, type: :component do
  let(:component) do
    Mcm::ComponentsPage.create!(
      page: Mcm::Page.create!(name: "Test Page"),
      component: Mcm::Component.find_by!(name: "hero_image"),
      name: "Test component",
      position: 1,
      active: true,
      metadata: { },
      assets_attributes: [
        { attachment: fixture_file_upload("hero_image.png") }
      ]
    )
  end

  before do
    # This component needs access to its parent's metadata
    component.create_parent!(
      page: component.page,
      component: Mcm::Component.find_by!(name: "hero_slider"),
      name: "Parent component",
      metadata: { height: 400 }
    )
  end

  it_behaves_like "a component"
 end
