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
  validates :description, length: { maximum: 150 }
  def non_available_day
    result = []
    result << 0 unless sunday?
    result << 1 unless monday?
    result << 2 unless tuesday?
    result << 3 unless wednesday?
    result << 4 unless thursday?
    result << 5 unless friday?
    result << 6 unless saturday?
    return result
  end

  def array_available_day
    result = []
    result << "Monday" if monday?
    result << "Tuesday" if tuesday?
    result << "Wednesday" if wednesday?
    result << "Thursday" if thursday?
    result << "Friday" if friday?
    result << "Saturday" if saturday?
    result << "Sunday" if sunday?
    return result
  end
end
