json.array!(@itineraries) do |itinerary|
  json.extract! itinerary, :id, :origin, :destination
  json.url itinerary_url(itinerary, format: :json)
end
