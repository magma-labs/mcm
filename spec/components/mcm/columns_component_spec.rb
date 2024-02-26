require "spec_helper"

RSpec.describe Mcm::ColumnsComponent, type: :component do
  let(:component) do
    Mcm::ComponentsPage.create!(
      page: Mcm::Page.create!(name: "Test Page"),
      component: Mcm::Component.find_by!(name: "columns"),
      name: "Test component",
      position: 1,
      active: true,
      metadata: { section_title: "Section 1" }
    )
  end

  it_behaves_like "a component"
  it_behaves_like "a container component"
 end
