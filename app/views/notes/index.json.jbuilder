json.array!(@notes) do |note|
  json.extract! note, :note
  json.url note_url(note, format: :json)
end
