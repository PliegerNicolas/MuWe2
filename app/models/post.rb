class Post < ApplicationRecord
  belongs_to :profile
  has_many :comments
  has_many :votes

  validates :original_message, presence: true
  validates :original_message, length: { maximum: 440,
                                         too_long: "%{count} characters is the maximum allowed" }
end
