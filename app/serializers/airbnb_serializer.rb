class AirbnbSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :image, :price, :location, :beds, :amenity, :category, :admin_id, :images
end
