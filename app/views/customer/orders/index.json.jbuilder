json.array!(@orders) do |order|
  json.extract! order, :id, :paid
  json.url order_url(order, format: :json)
end
