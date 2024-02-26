require "spec_helper"

RSpec.describe Mcm::RichTextComponent, type: :component do
  let(:component) do
    Mcm::ComponentsPage.create!(
      page: Mcm::Page.create!(name: "Test Page"),
      component: Mcm::Component.find_by!(name: "rich_text"),
      name: "Test component",
      position: 1,
      active: true,
      metadata: { body: "<h1>Lorem Ipsum</h1>" }
    )
  end

  it_behaves_like "a component"
end
