json.array!(@tickets) do |ticket|
  json.extract! ticket, :id, :code, :given_away
  json.url ticket_url(ticket, format: :json)
end
