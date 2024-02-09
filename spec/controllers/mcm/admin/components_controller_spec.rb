require "spec_helper"

RSpec.describe Mcm::Admin::ComponentsController, type: :controller do
  describe "#update" do
    let(:page) { Mcm::Page.create!(name: "Test Page") }
    let(:component_page) do
      Mcm::ComponentsPage.create!(
        page: page,
        component: Mcm::Component.find_by(name: "rich_text"),
        name: "Test component",
        position: 1,
        active: true,
        metadata: { body: "Lorem Ipsum" }
      )
    end

    context "when the as_draft param is present" do
      it "stores params as draft version" do
        put :update,
            params: {
              id: component_page.id,
              custom_page_id: page.id,
              use_route: :mcm,
              components_page: { metadata: { body: "Foo Bar" } },
              as_draft: true
            }

        expect(Mcm::ComponentsPage.non_draft.count).to be 1
        expect(Mcm::ComponentsPage.draft.count).to be 1
        expect(component_page.draft.metadata.json).to eq("body" => "Foo Bar")
      end

      context "when the original record has assets" do
        before do
          component_page.update! assets_attributes: [{ attachment: fixture_file_upload('hero_image.png') }]
        end

        it "switches assets with the draft" do
          asset_ids = component_page.assets.map(&:id)

          put :update,
              params: {
                id: component_page.id,
                custom_page_id: page.id,
                use_route: :mcm,
                components_page: { metadata: { body: "Foo Bar" } },
                as_draft: true
              }

          expect(component_page.reload.assets.map(&:id)).not_to eq asset_ids
          expect(component_page.draft.assets.map(&:id)).to eq asset_ids
        end

        context "when assets_attributes is present in params" do
          let(:asset_id) { component_page.assets.first.id }
          let(:attachment) { fixture_file_upload('hero_slider.png') }

          it "updates the draft's assets" do
            put :update,
                params: {
                  id: component_page.id,
                  custom_page_id: page.id,
                  use_route: :mcm,
                  components_page: { assets_attributes: [{ id: asset_id, attachment: attachment }] },
                  as_draft: true
                }

            expect(component_page.reload.draft.assets.first.attachment.filename).to eq 'hero_slider.png'
          end
        end
      end
    end

    shared_examples "components controller" do
      let(:form_params) do
        { metadata: { body: "Testing!" } }
      end

      it "updates the original record" do
        request
        expect(component_page.reload.metadata.json).to eq("body" => "Testing!")
      end

      it "deletes the draft version" do
        request
        expect { Mcm::ComponentsPage.find(draft_component.id) }.to raise_error ActiveRecord::RecordNotFound
      end

      context "when both the original and the draft have assets" do
        before do
          component_page.update! assets_attributes: [{ attachment: fixture_file_upload('hero_image.png') }]
          draft_component.update! assets_attributes: [{ attachment: fixture_file_upload('hero_slider.png') }]
        end

        it "switches assets between them" do
          request
          expect(component_page.reload.assets.count).to be 1
          expect(component_page.reload.assets.first.attachment.filename).to eq 'hero_slider.png'
        end
      end
    end

    context "when the as_draft param is not present" do
      let!(:draft_component) { component_page.create_draft_component }

      context "when the component has a draft version of itself" do
        let(:request) do
          put :update, params: {
            id: component_page.id,
            custom_page_id: page.id,
            use_route: :mcm,
            components_page: form_params
          }
        end

        include_examples "components controller"
      end

      context "when the component is itself a draft version of another component" do
        let(:request) do
          put :update, params: {
            id: draft_component.id,
            custom_page_id: page.id,
            use_route: :mcm,
            components_page: { metadata: { body: "Testing!" } }
          }
        end

        include_examples "components controller"
      end
    end
  end
end
