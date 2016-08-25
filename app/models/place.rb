class Place < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :whitelists, dependent: :destroy
  accepts_nested_attributes_for :whitelists, reject_if: :all_blank, allow_destroy: true
  has_attachment :photo, dependent: :destroy
end
