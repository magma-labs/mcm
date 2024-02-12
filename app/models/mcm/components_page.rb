# frozen_string_literal: true

module Mcm
  class ComponentsPage < Mcm::ApplicationRecord
    belongs_to :page
    belongs_to :component
    belongs_to :parent, class_name: 'Mcm::ComponentsPage', optional: true
    has_one :draft, class_name: 'Mcm::ComponentsPage', foreign_key: :draftable_id, dependent: :destroy
    belongs_to :draftable, class_name: 'Mcm::ComponentsPage', optional: true

    has_many :assets, dependent: :destroy
    accepts_nested_attributes_for :assets

    has_many :children, -> { non_draft }, class_name: 'Mcm::ComponentsPage',
                                          foreign_key: :parent_id,
                                          dependent: :destroy,
                                          inverse_of: :parent
    default_scope -> { order(:position) }

    validates :name, presence: true
    delegate :name, to: :component, prefix: true
    delegate :backend_template, :frontend_template, :full_width?, :multiple_images?, to: :presenter

    serialize :metadata, coder: Mcm::JsonSerializer

    scope :active, -> { where active: true }
    scope :top_level, -> { where parent_id: nil }
    scope :draft, -> { where.not draftable_id: nil }
    scope :non_draft, -> { where draftable_id: nil }

    before_create :fill_defaults
    before_create :calculate_position
    before_destroy :update_related_positions

    def presenter
      @presenter ||= "::Mcm::#{component_name.camelize}Presenter".constantize.new(self)
    end

    def respond_to_missing?(method, *args)
      metadata.respond_to?(method) || super(method, args)
    end

    def method_missing(method, *args)
      if respond_to_missing?(method)
        metadata.send(method, *args)
      else
        super
      end
    end

    # rubocop:disable Rails/SkipsModelValidations
    def move_to(new_position)
      brothers.where('position >= ? and position <= ?', new_position, position)
          .update_all('position = position + 1')

      update position: new_position
    end
    # rubocop:enable Rails/SkipsModelValidations

    def create_draft_component
      return unless draft.nil?

      self.draft = create_draft(
        attributes_for_draft.merge(assets: duplicate_assets, draftable_id: id)
      )
    end

    def attributes_for_draft
      attributes.except "id"
    end

    def attributes_for_draftable
      attributes.except "id", "draftable_id", "assets", "position"
    end

    def duplicate_assets
      assets.map do |asset|
        asset.dup.tap { |asset_dup| asset_dup.attachment.attach asset.attachment.blob }
      end
    end

    def switch_assets_with(target)
      raise "Not a #{self.class.to_s}!" unless target.is_a?(self.class)

      transaction do
        target_asset_ids = target.assets.map(&:id)
        assets.update_all components_page_id: target.id
        Mcm::Asset.where(id: target_asset_ids).update_all components_page_id: id

        target.reload
        reload
      end
    end

    def brothers
      parent_id ? parent.children.where.not(id: nil) : page.components_pages.top_level
    end

    def find_asset_for_position(position)
      assets.detect do |asset|
        asset.position == position
      end.presence || assets.new(position: position)
    end

    def update_related_positions
      brothers.where('position > ?', position)
          .update_all('position = position - 1') # rubocop:disable Rails/SkipsModelValidations
    end

    def draft?
      draftable_id.present?
    end

    private

    def fill_defaults
      self.metadata ||= presenter.defaults
    end

    def calculate_position
      self.position = (brothers.last&.position.presence || 0) + 1
    end

    def attributes_without_id(attributes)
      attributes.each.with_object([]) { |(_key, attrs), arr| arr << attrs.except(:id) }
    end
  end
end
