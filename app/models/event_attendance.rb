class EventAttendance < ApplicationRecord
  belongs_to :farmer
  belongs_to :event
  has_and_belongs_to_many :categories

  validates :farmer_id, presence: true
  validates :event_id, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
end
