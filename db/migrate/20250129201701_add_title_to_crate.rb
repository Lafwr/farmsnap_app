class AddTitleToCrate < ActiveRecord::Migration[7.1]
  def change
    add_column :crates, :name, :string
    add_column :crates, :description, :string
  end
end
