class Airbnb < ApplicationRecord
  belongs_to :admin
  has_many :airbnb_images, dependent: :destroy
  has_many :amenities, dependent: :destroy
  has_many :bookings, dependent: :destroy 
end
