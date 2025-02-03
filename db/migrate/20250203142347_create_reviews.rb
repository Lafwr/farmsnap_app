class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.string :content
      t.integer :rating
      t.text :comment

      t.timestamps
    end
  end
end
