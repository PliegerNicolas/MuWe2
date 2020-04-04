class Rating < ApplicationRecord
  belongs_to :participant
  belongs_to :user

  validates :rating, presence: true
  validates :rating, inclusion: { in: 1..5 }
end
