class Event < ApplicationRecord
  belongs_to :farmer
  has_many :event_attendances
  validates :name, presence: true
  validates :location, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  has_many :categories_events
  has_many :categories, through: :categories_events

  # Geocoding
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  # search bar

  include PgSearch::Model
  pg_search_scope :search_by_name_and_category,
  against: [:name, :location],
  associated_against: {
    categories: :name
  },
  using: {
    tsearch: { prefix: true } # Allows partial matches
  }
end
