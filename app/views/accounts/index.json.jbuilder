json.array!(@accounts) do |account|
  json.extract! account, :id, :end_date, :type, :description, :debit, :credit, :balance, :withdraw
  json.url account_url(account, format: :json)
end
