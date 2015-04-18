json.array!(@customers) do |customer|
  json.extract! customer, :id, :email, :password_digest, :firstname, :lastname, :address, :postcode, :city, :phone, :age, :gender
  json.url customer_url(customer, format: :json)
end
