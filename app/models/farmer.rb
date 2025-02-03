class Farmer < ApplicationRecord
  belongs_to :user
  # for the photo to function.
  has_one_attached :photo
  has_many :event_attendances
  has_many :events, through: :event_attendances
  has_many :crates


  validates :user_id, presence: true
  validates :bio, presence: true, length: { maximum: 300 }
  validates :location, presence: true


  # Geocoding
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?
end
