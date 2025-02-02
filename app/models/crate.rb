class Crate < ApplicationRecord
  belongs_to :farmer
  has_many :products
  validates :price, presence: true
  has_many :categories_crates
  has_many :categories, through: :categories_crates

  geocoded_by :current_location
  after_validation :geocode, if: :will_save_change_to_farmer?

  # search
  include PgSearch::Model
  pg_search_scope :search_by_name_and_products,
    against: [:name],
    associated_against: { products: [:name] },
    using: { tsearch: { prefix: true } }

    def current_location
      current_event = farmer.event_attendances.order(start_time: :desc).first&.event
      current_event ? current_event.location : farmer.location
    end

    def set_coordinates
      geocoded = Geocoder.search(current_location).first
      if geocoded
        self.latitude = geocoded.latitude
        self.longitude = geocoded.longitude
      end
    end
end
