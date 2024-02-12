class CreateMcmLocales < ActiveRecord::Migration[7.1]
  def change
    create_table :mcm_locales, if_not_exists: true do |t|
      t.references :localizable, polymorphic: true
      t.string :locale
      t.string :key
      t.string :value
    end
  end
end
