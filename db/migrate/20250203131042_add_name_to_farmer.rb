class AddNameToFarmer < ActiveRecord::Migration[7.1]
  def change
    add_column :farmers, :name, :string
  end
end
