class Cake < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_one_attached :photo

  validates :name, presence: true
  validates_uniqueness_of :name, scope: :user_id
  validates :price, presence: true
end
