class AddDayOfToDay < ActiveRecord::Migration[4.2]
  def change
    add_column :days, :day_of, :date
    add_index :days, :day_of
  end
end
