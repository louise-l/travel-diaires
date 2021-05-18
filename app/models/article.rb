class Article < ApplicationRecord
  belongs_to :author
  has_many :reviews, dependent: :destroy
  has_many :article_categories, dependent: :destroy
  has_many :categories, through: :article_categories
  
  validates :title, presence: true
  validates :description, presence: true
  validates :url_cover_picture, presence: true


  def calc_score
    scores = []
    self.reviews.each do |review|
      scores << review.rate
    end
    if scores.length == 0
      average = 0
    else
      average = scores.sum.to_f/scores.length
    end
    self.score = average
    self.save
  end

end
