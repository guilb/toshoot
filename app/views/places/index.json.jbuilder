json.array!(@places) do |place|
  json.extract! place, :id, :label, :address, :coordinates, :photo_url, :status, :lat, :lng
  json.url place_url(place, format: :json)
end
