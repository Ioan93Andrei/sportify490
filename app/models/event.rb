class Event < ApplicationRecord
  belongs_to :user
  has_many :users, through: :bookings
  has_many :bookings

  enum level: { Beginner: 1, Intermediate: 2, Advanced: 3, Pro: 4 }
end
