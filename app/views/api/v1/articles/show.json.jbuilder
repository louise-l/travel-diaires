json.extract! @article, :id, :title, :description, :url_cover_picture, :score, :created_at

json.author @article.author, :id, :username, :email

json.categories @article.categories do |cat|
  json.name cat.name
end

json.reviews @article.reviews do |review|
  json.author review.author.username
  json.extract! review, :id, :rate, :comment, :created_at
end
