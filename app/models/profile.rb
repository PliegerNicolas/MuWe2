class Profile < ApplicationRecord
  belongs_to :user
  belongs_to :address, optional: true
  has_many :posts
  has_one_attached :photo
end
