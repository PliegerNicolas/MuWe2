class Address < ApplicationRecord
  has_many :profiles
  has_many :jams

  validates :address, :latitude, :longitude, presence: true
end
