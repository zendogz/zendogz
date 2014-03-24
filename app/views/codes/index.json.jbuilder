json.array!(@codes) do |code|
  json.extract! code, :id, :set_id, :code, :description
  json.url code_url(code, format: :json)
end
