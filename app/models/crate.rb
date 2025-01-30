class Crate < ApplicationRecord
  belongs_to :farmer
  has_many :products
  validates :price, presence: true
  has_and_belongs_to_many :categories


  # search
  # include PgSearch::Model
  # multisearchable against: [:name, :products, :category]
end
