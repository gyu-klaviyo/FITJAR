json.array!(@devices) do |device|
  json.extract! device, :id, :device
  json.url device_url(device, format: :json)
end
