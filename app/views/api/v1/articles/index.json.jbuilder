json.array! @articles do |article|
  json.extract! article, :id, :title, :score, :description, :url_cover_picture, :created_at
  json.author article.author, :id, :username, :email
  json.categories article.categories, :name
end
