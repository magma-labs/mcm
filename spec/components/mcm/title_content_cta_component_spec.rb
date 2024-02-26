require "spec_helper"

RSpec.describe Mcm::TitleContentCtaComponent, type: :component do
  let(:component) do
    Mcm::ComponentsPage.create!(
      page: Mcm::Page.create!(name: "Test Page"),
      component: Mcm::Component.find_by!(name: "title_content_cta"),
      name: "Test component",
      position: 1,
      active: true,
      metadata: { title: "Test", content: "Foo Bar", cta_title: "Test", cta_url: "http://test.com" }
    )
  end

  it_behaves_like "a component"
 end
