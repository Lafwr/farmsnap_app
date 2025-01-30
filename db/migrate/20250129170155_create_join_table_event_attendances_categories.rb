class CreateJoinTableEventAttendancesCategories < ActiveRecord::Migration[7.1]
  def change
    create_join_table :event_attendances, :categories do |t|
      # t.index [:event_attendance_id, :category_id]
      # t.index [:category_id, :event_attendance_id]
    end
  end
end
