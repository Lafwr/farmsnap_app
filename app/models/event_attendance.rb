class EventAttendance < ApplicationRecord
  belongs_to :farmer
  belongs_to :event

  validates :farmer_id, presence: true
  validates :event_id, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  # validates :attendance_times_within_event_range

  private

  def attendance_times_within_event_range
    return unless event
    if start_time <event.start_time || end_time > event.end_time
      errors.add(:base, "Attendance time must be within event hours")
    end
    if start_time >= end_time
      errors.add(:base, "End time must be after start time")
    end
  end
end
