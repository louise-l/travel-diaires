json.extract! @article, :id, :title, :description, :url_cover_picture, :score, :created_at

json.author @article.author, :id, :username, :email

json.reviews @article.reviews do |review|
  json.extract! review, :rate, :comment, :created_at, :id
  json.author review.author.username
end