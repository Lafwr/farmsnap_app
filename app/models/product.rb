class Product < ApplicationRecord
  belongs_to :crate
  validates :name, :category, presence: true
end
