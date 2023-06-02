class CreateAirbnbs < ActiveRecord::Migration[7.0]
  def change
    create_table :airbnbs do |t|
      t.string :name
      t.string :location
      t.integer :price
      t.integer :beds
      t.text :description
      t.string :image
      t.string :amenity
      t.string :category
      t.references :admin, null: false, foreign_key: true
      t.timestamps
    end
  end
end
