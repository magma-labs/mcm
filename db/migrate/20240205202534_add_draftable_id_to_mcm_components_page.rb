class AddDraftableIdToMcmComponentsPage < ActiveRecord::Migration[5.2]
  def change
    change_table :mcm_components_pages do |t|
      t.belongs_to :draftable
    end
  end
end
