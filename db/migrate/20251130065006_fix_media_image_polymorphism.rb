class FixMediaImagePolymorphism < ActiveRecord::Migration[8.0]
  def change
		remove_column :media_images, :attachable_type
		add_column :media_images, :attachable_type, :string, default: 'MediaWork'
  end
end
