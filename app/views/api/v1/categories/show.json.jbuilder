json.extract! @category, :id, :name

json.articles @category.articles do |article|
  json.extract! article, :id, :author_id, :title, :description, :url_cover_picture, :score, :created_at
end