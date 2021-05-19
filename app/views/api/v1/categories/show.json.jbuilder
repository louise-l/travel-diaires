json.extract! @category, :id, :name

json.articles @category.articles do |article|
  json.extract! article, :id, :title,  :score, :description, :url_cover_picture, :created_at
  json.author article.author, :id, :username, :email
end