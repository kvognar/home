class AddContentWarningToTags < ActiveRecord::Migration
  def change
    add_column :tags, :content_warning, :boolean, default: false
  end
end
