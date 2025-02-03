class AddFarmerToReviews < ActiveRecord::Migration[7.1]
  def change
    add_reference :reviews, :farmer, null: false, foreign_key: true
  end
end
