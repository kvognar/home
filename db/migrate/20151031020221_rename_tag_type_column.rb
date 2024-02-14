class RenameTagTypeColumn < ActiveRecord::Migration[4.2]
  def change
    rename_column :tags, :type, :tag_type
  end
end
