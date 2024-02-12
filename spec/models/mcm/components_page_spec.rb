# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Mcm::ComponentsPage, type: :model do
  let!(:page) { Mcm::Page.create!(name: 'Testing page') }

  before :each do
    Mcm::Component.containers.each do |component|
      page.components_pages.create!(component: component, name: "Test #{component.name}")
    end

    Mcm::Component.content.each_with_index do |component, index|
      page.components_pages.top_level[index % 2].children.create!(component: component, name: "Test #{component.name}", page: page)
    end
  end

  describe '#move_to' do
    let!(:first_component) { page.components_pages.top_level.first }

    context 'when moving top level components' do
      let!(:second_component) { page.components_pages.top_level.second }
      let(:columns) { Mcm::Component.find_by(name: 'columns') }
      let!(:third_component) do
        page.components_pages.create(name: 'another test', component: columns)
      end

      before do
        second_component.move_to(1)
      end

      it 'moves the second element to the first spot' do
        expect(second_component.reload.position).to eq(1)
      end

      it 'moves the first element to the second spot' do
        expect(first_component.reload.position).to eq(2)
      end

      it 'doesnt change third element position' do
        expect(third_component.reload.position).to eq(3)
      end
    end

    context 'when moving children components' do
      let!(:first_sub_component) { first_component.children.first }
      let!(:third_sub_component) { first_component.children.third }
      let!(:last_sub_component) { first_component.children.last }

      before do
        last_sub_component.move_to(1)
      end

      it 'moves the last element to the first spot' do
        expect(first_sub_component.reload.position).to be(2)
      end

      it 'moves third element position to fourth spot' do
        expect(third_sub_component.reload.position).to eq(4)
      end
    end

    context 'when creating a new component' do
      it 'adds it to the end' do
        component = page.components_pages.create(name: 'Testing',
                                                 component: Mcm::Component.containers.first)
        expect(component.position).to be(3)
      end
    end

    context 'when creating a new child component' do
      it 'adds it to the end' do
        component = first_component.children.create(name: 'Testing',
                                                    component: Mcm::Component.content.first,
                                                    page: page)
        expect(component.position).to be(first_component.children.reload.last.position)
      end
    end
  end

  describe '#update_related_positions' do
    let!(:first_component) { page.components_pages.top_level.first }
    let!(:second_component) { page.components_pages.top_level.second }
    let!(:first_first_sub_component) { first_component.children.first }
    let!(:first_last_sub_component) { first_component.children.last }
    let!(:second_first_sub_component) { second_component.children.first }

    it 'update positions in related components' do
      expect do
        first_component.update_related_positions
        second_component.reload
      end.to change(second_component, :position).by(-1)
    end

    context 'with children sub components' do
      it 'update related children components position correctly' do
        expect do
          first_first_sub_component.update_related_positions
          first_last_sub_component.reload
        end.to change(first_last_sub_component, :position).by(-1)
      end

      it 'doesnt update other component children' do
        expect do
          first_first_sub_component.update_related_positions
          second_first_sub_component.reload
        end.not_to change(second_first_sub_component, :position)
      end
    end
  end

  describe "#create_draft_component" do
    let(:component) { Mcm::ComponentsPage.first }
    let(:draft_component) { Mcm::ComponentsPage.draft.first }

    context "when no draft record exists for the component" do
      it "creates a draft record" do
        expect { component.create_draft_component }.to change { Mcm::ComponentsPage.draft.count }.from(0).to(1)

        expect(draft_component.draftable_id).to eq component.id
        expect(draft_component.metadata.json).to eq component.metadata.json

        attributes = %w[id draftable_id metadata position]
        expect(draft_component.attributes.except(*attributes)).to eq component.attributes.except(*attributes)
      end

      context "when the original record has assets" do
        before do
          component.update!(
            assets_attributes: [
              { attachment: fixture_file_upload('hero_image.png') },
              { attachment: fixture_file_upload('hero_slider.png') }
            ]
          )
        end

        it "creates copies of the assets for the draft record" do
          component.create_draft_component

          expect(draft_component.assets.count).to eq 2
          expect(draft_component.assets.first.attachment.filename).to eq 'hero_image.png'
          expect(draft_component.assets.second.attachment.filename).to eq 'hero_slider.png'
          expect(ActiveStorage::Attachment.count).to eq component.assets.count + draft_component.assets.count
        end
      end
    end
  end

  describe "#switch_assets_with" do
    subject { Mcm::ComponentsPage.first }
    let(:target) { Mcm::ComponentsPage.second }

    before do
      subject.assets.create! id: 1000
      target.assets.create! id: 2000
    end

    it "switches assets with target" do
      subject.switch_assets_with target

      expect(subject.reload.assets.first.id).to eq 2000
      expect(target.reload.assets.first.id).to eq 1000
    end
  end
end
