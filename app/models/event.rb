class Event < ApplicationRecord
  belongs_to :farmer
  has_many :event_attendances
  validates :name, presence: true
  validates :location, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  has_and_belongs_to_many :categories

  # Geocoding
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?



  # OPTION 1:
  include PgSearch::Model
  pg_search_scope :search_by_name_and_category,
  against: [:name, :location],
  associated_against: {
    categories: :name
  },
  using: {
    tsearch: { prefix: true } # Allows partial matches
  }
  # OPTION 2:
  # include PgSearch::Model
  # multisearchable against: [:name, :category]
end
