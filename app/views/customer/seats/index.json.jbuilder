json.array!(@seats) do |seat|
  json.extract! seat, :id, :table, :seat, :x, :y, :angle
  json.url seat_url(seat, format: :json)
end
