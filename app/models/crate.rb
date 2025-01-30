class Crate < ApplicationRecord
  belongs_to :farmer
  has_many :products
  validates :price, presence: true

  # search
  include PgSearch::Model
  pg_search_scope :search_by_name_and_products,
    against: [:name],
    associated_against: { products: [:name] },
    using: { tsearch: { prefix: true } }
end
