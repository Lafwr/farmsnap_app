class CategoriesCrate < ApplicationRecord
  belongs_to :crate
  belongs_to :category
end
