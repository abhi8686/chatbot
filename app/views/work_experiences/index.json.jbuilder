json.array!(@work_experiences) do |work_experience|
  json.extract! work_experience, :id, :companyName, :designation, :location
  json.url work_experience_url(work_experience, format: :json)
end
