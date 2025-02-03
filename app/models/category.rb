class Category < ApplicationRecord
  has_many :categories_crates
  has_many :categories_events
end
