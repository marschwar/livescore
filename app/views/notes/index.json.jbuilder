json.array!(@notes) do |note|
  json.extract! note, :created_at, :text
end
