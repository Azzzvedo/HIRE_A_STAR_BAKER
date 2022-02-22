class Cake < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_one_attached :photo


  validates :name, presence: true, uniqueness: true
  validates :price, presence: true
end
