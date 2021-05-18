json.array! @categories do |category|
  json.extract! category, :id, :name
  json.articles category.articles, :id, :title
end
