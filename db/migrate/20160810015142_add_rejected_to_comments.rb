class AddRejectedToComments < ActiveRecord::Migration
  def change
    add_column :comments, :rejected, :boolean, default: false
    add_index :comments, :rejected
  end
end
