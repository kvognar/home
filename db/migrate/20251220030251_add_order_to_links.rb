class AddOrderToLinks < ActiveRecord::Migration[8.0]
  def change
		add_column :links, :order, :integer, default: 100
  end
end
