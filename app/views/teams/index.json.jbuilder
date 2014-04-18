json.array!(@teams) do |team|
  json.extract! team, :id, :name, :encoded_image
  json.url team_url(team, format: :json)
end
