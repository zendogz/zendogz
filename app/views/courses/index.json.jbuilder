json.array!(@courses) do |course|
  json.extract! course, :name, :description
  json.url course_url(course, format: :json)
end
