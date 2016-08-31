class Booking < ApplicationRecord
  belongs_to :place
  belongs_to :user
  validates :start_time, presence: true
  validates :end_time, presence: true
end
