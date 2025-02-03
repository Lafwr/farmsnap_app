class Product < ApplicationRecord
  belongs_to :crate
  validates :name, :category, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
end
