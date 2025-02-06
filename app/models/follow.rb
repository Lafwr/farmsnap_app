class Follow < ApplicationRecord
  belongs_to :user
  belongs_to :farmer
end
