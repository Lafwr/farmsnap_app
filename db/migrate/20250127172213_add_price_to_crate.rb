class AddPriceToCrate < ActiveRecord::Migration[7.1]
  def change
    add_column :crates, :price, :decimal, precision: 10, scale: 2
  end
end
