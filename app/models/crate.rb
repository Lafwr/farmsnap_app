class Crate < ApplicationRecord
  belongs_to :farmer
  has_many :products
  validates :price, presence: true
end
