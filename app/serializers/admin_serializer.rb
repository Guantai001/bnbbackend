class AdminSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :password_digest, :image 
end
