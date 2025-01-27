class CreateFarmers < ActiveRecord::Migration[7.1]
  def change
    create_table :farmers do |t|
      t.references :user, null: false, foreign_key: true
      t.string :bio
      t.string :location

      t.timestamps
    end
  end
end
