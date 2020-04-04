class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :votes

  validates :comment, presence: true
  validates :comment, length: { maximum: 440,
                                too_long: "%{count} characters is the maximum allowed" }
end
