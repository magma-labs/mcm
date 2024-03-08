require "spec_helper"

RSpec.describe Mcm::YoutubeVideoComponent, type: :component do
  let(:component) do
    Mcm::ComponentsPage.create!(
      page: Mcm::Page.create!(name: "Test Page"),
      component: Mcm::Component.find_by!(name: "youtube_video"),
      name: "Test component",
      position: 1,
      active: true,
      metadata: { }
    )
  end

  it_behaves_like "a component"
 end
