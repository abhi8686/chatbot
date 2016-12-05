json.array!(@educational_details) do |educational_detail|
  json.extract! educational_detail, :id, :collageName, :courseName, :location
  json.url educational_detail_url(educational_detail, format: :json)
end
