class CreateCrates < ActiveRecord::Migration[7.1]
  def change
    create_table :crates do |t|
      t.references :farmer, null: false, foreign_key: true
      t.boolean :flash_sale, default: false

      t.timestamps
    end
  end
end
