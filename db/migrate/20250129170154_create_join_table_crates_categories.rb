class CreateJoinTableCratesCategories < ActiveRecord::Migration[7.1]
  def change
    create_join_table :crates, :categories do |t|
      # t.index [:crate_id, :category_id]
      # t.index [:category_id, :crate_id]
    end
  end
end
