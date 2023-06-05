class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.string :from_date
      t.string :to_date
      t.integer :paid_amount
      t.string :phone_number

      t.references :user, null: false, foreign_key: true
      t.references :airbnb, null: false, foreign_key: true

      t.timestamps
    end
  end
end
