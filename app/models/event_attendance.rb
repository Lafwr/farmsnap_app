class EventAttendance < ApplicationRecord
  belongs_to :farmer
  belongs_to :event
  validates :farmer_id, presence: true
  validates :event_id, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
end
