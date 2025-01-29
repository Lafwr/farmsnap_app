class Event < ApplicationRecord
  belongs_to :farmer
  has_many :event_attendances
  validates :name, presence: true
  validates :location, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true

  # Geocoding
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?
end
