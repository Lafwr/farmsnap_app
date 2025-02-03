class AddCoordinatesToCrates < ActiveRecord::Migration[7.1]
  def change
    add_column :crates, :latitude, :float
    add_column :crates, :longitude, :float
  end
end
