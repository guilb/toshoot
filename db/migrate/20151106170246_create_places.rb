class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :label
      t.string :address
      t.string :coordinates
      t.string :photo_url
      t.integer :status

      t.timestamps null: false
    end
  end
end
