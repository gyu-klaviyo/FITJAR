json.array!(@questions) do |question|
  json.extract! question, :id, :subject
  json.url question_url(question, format: :json)
end
