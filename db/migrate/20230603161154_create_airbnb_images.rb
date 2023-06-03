class CreateAirbnbImages < ActiveRecord::Migration[7.0]
  def change
    create_table :airbnb_images do |t|
      t.string :image

      t.references :airbnb, null: false, foreign_key: true
      t.timestamps
    end
  end
end
