json.array!(@enrollments) do |enrollment|
  json.extract! enrollment, :id, :person_id, :course_id
  json.url enrollment_url(enrollment, format: :json)
end
