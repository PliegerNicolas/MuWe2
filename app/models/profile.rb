class Profile < ApplicationRecord
  after_validation :geocode

  reverse_geocoded_by :latitude, :longitude

  belongs_to :user
  has_one :address
  has_many :posts
  has_one_attached :photo
end
