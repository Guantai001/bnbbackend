class AirbnbSerializer < ActiveModel::Serializer
  attributes :id, :admin_id, :name
  has_many :airbnb_images
end
