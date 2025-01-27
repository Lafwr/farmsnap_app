class CreateEventAttendances < ActiveRecord::Migration[7.1]
  def change
    create_table :event_attendances do |t|
      t.references :farmer, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
