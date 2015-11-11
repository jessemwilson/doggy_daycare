json.array!(@owners) do |owner|
  json.extract! owner, :id, :first_name, :last_name, :phone, :email, :evac_waiver
  json.url owner_url(owner, format: :json)
end
