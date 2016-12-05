json.array!(@a_brief_about_yourselves) do |a_brief_about_yourself|
  json.extract! a_brief_about_yourself, :id, :body
  json.url a_brief_about_yourself_url(a_brief_about_yourself, format: :json)
end
