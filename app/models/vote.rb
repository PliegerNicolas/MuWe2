class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :post, optional: true
  belongs_to :comment, optional: true

  validates :rating, presence: true
  validates :rating, inclusion: { in: -1..1 }
end
