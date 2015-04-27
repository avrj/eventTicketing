json.array!(@seats) do |seat|
  json.extract! seat, :id, :x, :y
  json.type seat.ticket.ticket_type.name
  if seat.ticket.reservation.nil?
  json.status "free"
  else
    json.status "reserved"
    end
end
