class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.string :from_date
      t.string :to_date
      t.integer :estimated_amount
      t.integer :difference_in_nights

      t.references :user, null: false, foreign_key: true
      t.references :airbnb, null: false, foreign_key: true
      t.timestamps
    end
  end
end
