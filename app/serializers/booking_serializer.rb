class BookingSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :airbnb_id, :from_date, :to_date, :paid_amount, :phone_number
  belongs_to :user
  belongs_to :airbnb
end
