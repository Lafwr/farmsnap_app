class Order < ApplicationRecord
  belongs_to :event
  belongs_to :crate

  validates :name, :email, :event_id, presence: true
end
