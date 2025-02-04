class AddColumnToCrates < ActiveRecord::Migration[7.1]
  def change
    add_reference :crates, :event, foreign_key: true
  end
end
