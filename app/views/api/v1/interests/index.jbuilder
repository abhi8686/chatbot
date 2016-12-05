json.name @user.name
#json.created_at @user.created_at.to_time.iso8601
json.created_at @user.created_at.strftime("%d/%m/%Y")
json.about @user.a_brief_about_yourself.try(:body)
json.work_experience do
  json.company_name @user.work_experience.companyName
  json.designation @user.work_experience.designation
  json.location @user.work_experience.location
end
json.educational_details do
  json.college @user.educational_detail.collageName
  json.course @user.educational_detail.courseName
  json.location @user.educational_detail.location
end
json.interests @interests do |interest|
  json.id interest.tag.id
  json.name interest.tag.name
end