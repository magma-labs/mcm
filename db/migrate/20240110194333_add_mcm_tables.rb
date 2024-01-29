class AddMcmTables < ActiveRecord::Migration[5.2]
  def change
    create_table :mcm_pages, if_not_exists: true do |t|
      t.string :name
      t.string :path, index: { unique: true }
      t.json :metadata
      t.timestamp :discarded_at
      t.boolean :active, default: false
      t.timestamps
    end

    create_table :mcm_components, if_not_exists: true do |t|
      t.string :name
      t.string :component_type
      t.boolean :active, default: false
      t.timestamps
    end

    create_table :mcm_components_pages, if_not_exists: true do |t|
      t.references :page
      t.references :component
      t.references :parent
      t.string :name
      t.integer :position
      t.boolean :active, default: false
      t.json :metadata
    end
  end
end
