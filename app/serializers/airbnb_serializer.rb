class AirbnbSerializer < ActiveModel::Serializer
  attributes :id, :admin_id, :name, :location, :price, :beds, :description, :category
  has_many :airbnb_images
  has_many :amenities
end
