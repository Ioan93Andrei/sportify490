class Event < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :users, through: :bookings
  has_many :reviews, dependent: :destroy

  validates :date, :capacity, :price, :location, :sport, :level, :description, :name, presence: true

  include PgSearch::Model
  pg_search_scope :global_search,
  against: [:location, :sport, :level, :date]

  pg_search_scope :date_search,
  against: [:date]

  pg_search_scope :sport_search,
  against: [:sport],
  using: {
    tsearch: { prefix: true }
  }

  pg_search_scope :location_search,
  against: [:location],
  using: {
    tsearch: { prefix: true }
  }

  pg_search_scope :level_search,
  against: [:level]

  enum level: { beginner: 1, intermediate: 2, advanced: 3, pro: 4 }

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?
end
