# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "faker"

puts "-------------------------------"
puts "Destroying everything"
puts "-------------------------------"

Review.destroy_all
ArticleCategory.destroy_all
Author.destroy_all
Category.destroy_all
Article.destroy_all

puts "Creating categories"

  ["Miam miam", "Europe", "Asie", "Amériques", "A pied", "Budget friendly", "Wikihow"].each do |category|
    Category.create!(name: category)
    puts "."
  end


puts "#{Category.count} categories created"




puts "Creating authors"

  10.times do 
    Author.create!(username: Faker::Internet.username, password: Faker::Internet.password, email: Faker::Internet.email)
    puts "."
  end 

puts "#{Author.count} authors created"

puts "Creating articles + connect with categories and reviews"

  Author.all.each_with_index do |author, index|
    rand(2..4).times do 
      url = RestClient.get("https://source.unsplash.com/random/1200x700/?backpacking")
      Article.create!(title: Faker::Address.country, description: Faker::Lorem.sentence(word_count: 80), url_cover_picture: url.request.url, author: author, created_at: Time.current - index.day)
      puts "."
    end
  end

  categories = Category.all.to_a.shuffle
  # on assigne 2 categories au hasard pour chaque article
  Article.all.each do |article|
    article.categories << categories.sample(2)
  end

  # on ajoute les reviews aux articles
  authors = Author.all.to_a.shuffle
  Article.all.each do |article|
    rand(0..10).times do 
      Review.create!(comment: Faker::Quote.yoda, rate: rand(1..5), author: authors.sample, article: article)
    end
    # grâce à une méthode de classe, on calcule la note moyenne de l'article
    article.calc_score
  end

puts "#{Article.count} articles created and #{Review.count} reviews"

