class AddCoordinatesToFarmers < ActiveRecord::Migration[7.1]
  def change
    add_column :farmers, :latitude, :float
    add_column :farmers, :longitude, :float
  end
end
