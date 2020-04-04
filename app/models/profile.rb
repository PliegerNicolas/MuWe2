class Profile < ApplicationRecord
  after_create :attach_default_profile_image
  after_validation :geocode

  reverse_geocoded_by :latitude, :longitude

  belongs_to :user
  has_one :address
  has_many :posts
  has_one_attached :photo

  def attach_default_profile_image
    require 'open-uri'

    image_path = 'https://extraupdate.com/wp-content/uploads/2019/02/map_img_1138084_1501023103.jpg'
    file = URI.open(image_path)
    filename = File.basename(URI.parse(image_path).path)
    photo.attach(io: file, filename: filename)
  end
end
