class Farmer < ApplicationRecord
  belongs_to :user
  has_many :event_attendances
  has_many :events, through: :event_attendances
  has_many :crates

  validates :user_id, presence: true
  validates :bio, presence: true, length: { maximum: 300 }
  validates :location, presence: true

end
