class AddColorItinerary < ActiveRecord::Migration
  def change
  	   change_column :itineraries, :destination, :string
      		add_column :itineraries, :color, :string


  end
end
