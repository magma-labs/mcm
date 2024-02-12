class RemovePathFromMcmPages < ActiveRecord::Migration[5.2]
  def change
    remove_column :mcm_pages, :path
  end
end
