json.array!(@lessons) do |lesson|
  json.extract! lesson, :id, :name, :handout, :lesson_at, :status
  json.url lesson_url(lesson, format: :json)
end
