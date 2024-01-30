class RemovePathFromMcmPages < ActiveRecord::Migration[7.1]
  def change
    remove_column :mcm_pages, :path
  end
end
