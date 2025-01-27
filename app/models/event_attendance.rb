class EventAttendance < ApplicationRecord
  belongs_to :farmer
  belongs_to :event
end
