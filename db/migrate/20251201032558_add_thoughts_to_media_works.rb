class AddThoughtsToMediaWorks < ActiveRecord::Migration[8.0]
  def change
		add_column :media_works, :thoughts, :text
  end
end
