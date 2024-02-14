class ChangeCommentDefaultParent < ActiveRecord::Migration[4.2]
  def change
    change_column_default :comments, :parent_id, 0
  end
end
