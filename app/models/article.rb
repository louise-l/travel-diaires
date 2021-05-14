class Article < ApplicationRecord
  belongs_to :author
  has_many :reviews, dependent: :destroy
  has_many :categories, through: :article_categories
  has_many :article_categories

end
