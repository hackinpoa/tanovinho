json.array!(@products) do |product|
  json.extract! product, :id, :name, :slug, :description, :price
  json.url product_url(product, format: :json)
end
