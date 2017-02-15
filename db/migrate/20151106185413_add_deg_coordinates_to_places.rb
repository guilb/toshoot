class AddDegCoordinatesToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :deg_coordinates, :string
  end
end
