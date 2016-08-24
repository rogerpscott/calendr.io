class Place < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :whitelists, dependent: :destroy
  has_attachment :photo, dependent: :destroy
end
