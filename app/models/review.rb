class Review < ApplicationRecord
  belongs_to :article
  belongs_to :author

  validates :rate, presence: true
  validates :rate, numericality: { in: 0..5 }

end
