json.array!(@l1s) do |l1|
  json.extract! l1, :id, :a
  json.url l1_url(l1, format: :json)
end
