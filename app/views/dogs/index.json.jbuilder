json.array!(@dogs) do |dog|
  json.extract! dog, :id, :name, :breed_id, :owner_id, :med_cond, :vet, :dob
  json.url dog_url(dog, format: :json)
end
