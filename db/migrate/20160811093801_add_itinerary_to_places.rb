class AddItineraryToPlaces < ActiveRecord::Migration
  def change
      add_column :places, :itinerary, :integer
  end
end
