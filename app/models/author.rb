class Author < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :articles, dependent: :destroy
end
