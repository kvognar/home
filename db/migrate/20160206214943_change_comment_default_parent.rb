class ChangeCommentDefaultParent < ActiveRecord::Migration
  def change
    change_column_default :comments, :parent_id, 0
  end
end
