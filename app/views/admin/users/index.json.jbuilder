json.array!(@admins) do |admin|
  json.extract! admin, :id, :username, :password_digest, :superuser
  json.url admin_url(admin, format: :json)
end
