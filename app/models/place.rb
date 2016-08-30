class Place < ApplicationRecord
  extend FriendlyId
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :whitelists, dependent: :destroy
  accepts_nested_attributes_for :whitelists, reject_if: :all_blank, allow_destroy: true
  has_attachment :photo, dependent: :destroy
  geocoded_by :address
  after_validation :geocode, if: Proc.new { |a| a.address_changed? && a.latitude.nil? }

  friendly_id :name, use: :slugged
end
