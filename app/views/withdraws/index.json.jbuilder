json.array!(@withdraws) do |withdraw|
  json.extract! withdraw, :id, :amount
  json.url withdraw_url(withdraw, format: :json)
end
