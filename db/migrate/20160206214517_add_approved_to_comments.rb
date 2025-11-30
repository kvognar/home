class AddApprovedToComments < ActiveRecord::Migration[4.2]
  def change
    add_column :comments, :approved, :boolean, default: true
    add_index :comments, :approved
  end
end
