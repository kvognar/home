class ChangeDayColumnNulls < ActiveRecord::Migration
  def change
    change_column_null :days, :title, true
    change_column_null :days, :publish_date, true
    change_column_null :days, :body, true
    change_column_null :days, :slug, true
  end
end
