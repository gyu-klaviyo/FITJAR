json.array!(@payments) do |payment|
  json.extract! payment, :id, :address, :city, :state
  json.url payment_url(payment, format: :json)
end
