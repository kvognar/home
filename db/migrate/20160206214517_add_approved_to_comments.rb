class AddApprovedToComments < ActiveRecord::Migration
  def change
    add_column :comments, :approved, :boolean, default: true
    add_index :comments, :approved
  end
end
