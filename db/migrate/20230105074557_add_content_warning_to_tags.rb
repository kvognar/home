class AddContentWarningToTags < ActiveRecord::Migration[4.2]
  def change
    add_column :tags, :content_warning, :boolean, default: false
  end
end
