class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.references :farmer, null: false, foreign_key: true
      t.text :caption

      t.timestamps
    end
  end
end
