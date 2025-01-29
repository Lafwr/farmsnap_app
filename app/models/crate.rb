class Crate < ApplicationRecord
  belongs_to :farmer
  has_many :products
  validates :price, presence: true

  # search
  # include PgSearch::Model
  # multisearchable against: [:name, :products, :category]
end
