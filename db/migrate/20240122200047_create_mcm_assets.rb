class CreateMcmAssets < ActiveRecord::Migration[7.1]
  def change
    create_table :mcm_assets, if_not_exists: true do |t|
      t.belongs_to :components_page
      t.integer :position
      t.timestamps
    end
  end
end
