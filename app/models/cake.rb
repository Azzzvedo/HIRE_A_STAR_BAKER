class Cake < ApplicationRecord
  belongs_to :user
  include PgSearch::Model
  pg_search_scope :global_search,
    against: [ :name ],
    associated_against: {
      user: [ :first_name, :last_name ]
    },
    using: {
      tsearch: { prefix: true }
    }
  has_many :bookings, dependent: :destroy
  has_one_attached :photo

  validates :name, presence: true
  validates_uniqueness_of :name, scope: :user_id
  validates :price, presence: true
end
