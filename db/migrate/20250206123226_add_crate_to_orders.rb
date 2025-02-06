class AddCrateToOrders < ActiveRecord::Migration[7.1]
  def change
    add_reference :orders, :crate, foreign_key: true
  end
end
