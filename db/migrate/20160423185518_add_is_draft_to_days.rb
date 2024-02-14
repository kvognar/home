class AddIsDraftToDays < ActiveRecord::Migration[4.2]
  def change
    add_column :days, :is_draft, :boolean, default: false, null: false
    add_index :days, :is_draft
  end
end
