class ReservationSerializer < ActiveModel::Serializer
  attributes :id, :from_date, :to_date, :airbnb_id, :user_id, :estimated_amount, :difference_in_nights
end
