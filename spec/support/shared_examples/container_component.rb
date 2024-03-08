require_relative "../mcm/failing_component"

shared_examples "a container component" do
  context "when rendering children components" do
    before do
      component.children.create!(
        page: component.page,
        component: Mcm::Component.find_by!(name: "rich_text"),
        name: "Child component",
        active: true,
        metadata: { body: "Foo Bar" }
      )
    end

    it "renders child components" do
      render_inline Mcm::ColumnsComponent.new(component: component)

      expect(page).to have_content "Foo Bar"
    end

    context "when something goes wrong with a child component" do
      before do
        failing_component = Mcm::Component.create! name: "failing", component_type: "content"
        component.children.create!(
          page: component.page,
          component: failing_component,
          name: "Child component",
          active: true
        )
      end

      it "renders an error message" do
        render_inline Mcm::ColumnsComponent.new(component: component)

        expect(page).to have_content I18n.t('custom_pages.messages.something_went_wrong')
      end

      it "renders the rest of the child components" do
        render_inline Mcm::ColumnsComponent.new(component: component)

        expect(page).to have_content "Foo Bar"
      end
    end
  end
end
