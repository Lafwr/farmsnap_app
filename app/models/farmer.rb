class Farmer < ApplicationRecord
  belongs_to :user
  # for the photo to function.
  has_one_attached :photo
  has_many :event_attendances
  has_many :events, through: :event_attendances
  has_many :crates

  has_many :posts, dependent: :destroy
  has_many :reviews


  validates :user_id, presence: true
  validates :bio, presence: true, length: { maximum: 300 }
  validates :location, presence: true

  # FOLLOWERS
  class Farmer < ApplicationRecord
    has_many :follows, dependent: :destroy
    has_many :followers, through: :follows, source: :user
  end



  # Geocoding
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?
end
