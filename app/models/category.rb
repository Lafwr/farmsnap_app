class Category < ApplicationRecord
  has_and_belongs_to_many :crates
  has_and_belongs_to_many :event_attendances
  has_and_belongs_to_many :events
end
