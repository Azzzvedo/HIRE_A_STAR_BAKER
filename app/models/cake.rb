class Cake < ApplicationRecord
  belongs_to :user
  has many :bookings
  validates :name, presence: true
  validates :price, presence: true
end
