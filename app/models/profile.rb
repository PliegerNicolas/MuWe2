class Profile < ApplicationRecord
  belongs_to :user
  has_one :address
  has_many :posts
  has_one_attached :photo
end
