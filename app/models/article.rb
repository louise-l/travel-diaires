class Article < ApplicationRecord
  belongs_to :author
  has_many :reviews, dependent: :destroy
  has_many :article_categories
  has_many :categories, through: :article_categories

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
