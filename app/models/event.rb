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

  # search bar

  # OPTION 1:
  include PgSearch::Model
  pg_search_scope :search_by_name_and_category,
    against: [ :name, :category ],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
  # OPTION 2:
  # include PgSearch::Model
  # multisearchable against: [:name, :category]
end
