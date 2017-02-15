class AddDisplayOnMapOnItineraries < ActiveRecord::Migration
  def change
  	add_column :itineraries, :display_on_map, :boolean

  end
end
