class Post < ApplicationRecord
  belongs_to :farmer
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :image
  # has_many_attached :images
  # MULTIPLE OPTIONAL IMAGE ATTACHMENTS

  validates :caption, presence: true
end
