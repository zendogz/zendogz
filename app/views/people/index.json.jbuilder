json.array!(@people) do |person|
  json.extract! person, :name, :email, :address, :city, :postal, :phone_home, :phone_cell, :phone_work, :authority, :born_on
  json.url person_url(person, format: :json)
end
