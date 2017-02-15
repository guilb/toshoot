class CreateItineraries < ActiveRecord::Migration
  def change
    create_table :itineraries do |t|
      t.string :origin
      t.integer :destination

      t.timestamps null: false
    end
  end
end
