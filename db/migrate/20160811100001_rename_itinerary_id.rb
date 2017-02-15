class RenameItineraryId < ActiveRecord::Migration
  def change
  	rename_column :places, :itinerary, :itinerary_id

  end
end
