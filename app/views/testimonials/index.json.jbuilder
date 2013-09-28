json.array!(@testimonials) do |testimonial|
  json.extract! testimonial, :from, :body
  json.url testimonial_url(testimonial, format: :json)
end
