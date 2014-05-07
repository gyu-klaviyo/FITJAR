json.array!(@challenges) do |challenge|
  json.extract! challenge, :id, :name, :description, :stake, :duration
  json.url challenge_url(challenge, format: :json)
end
