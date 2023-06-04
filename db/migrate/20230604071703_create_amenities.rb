class CreateAmenities < ActiveRecord::Migration[7.0]
  def change
    create_table :amenities do |t|
      t.string :item1
      t.string :item2
      t.string :item3
      t.string :item4
      t.string :item5
      t.string :item6
      
      t.references :airbnb, null: false, foreign_key: true
      t.timestamps
    end
  end
end
