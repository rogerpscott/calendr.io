class Place < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many :whitelists
  has_attachment :photo
end
