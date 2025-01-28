class AddCategoriesToEvent < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :category, :string
  end
end
