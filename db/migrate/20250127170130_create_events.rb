class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :name
      t.references :farmer, null: false, foreign_key: true
      t.string :location
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
