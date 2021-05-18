class Author < ApplicationRecord
  # identification de l'utilisateur dans l'API
  acts_as_token_authenticatable


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_many :reviews, dependent: :destroy
  has_many :articles, dependent: :destroy
end
