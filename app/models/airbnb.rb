class Airbnb < ApplicationRecord
  belongs_to :admin
  has_many :airbnb_images, dependent: :destroy
end
