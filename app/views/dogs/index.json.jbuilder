json.array!(@dogs) do |dog|
  json.extract! dog, :name, :breed, :colour, :born_on
  json.url dog_url(dog, format: :json)
end
