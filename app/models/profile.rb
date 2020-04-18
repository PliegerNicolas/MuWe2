class Profile < ApplicationRecord
  after_create :attach_default_profile_photo

  belongs_to :user
  has_one :address
  has_many :posts
  has_one_attached :photo
  has_one_attached :banner

  def attach_default_profile_photo
    require 'open-uri'

    image_path = 'https://extraupdate.com/wp-content/uploads/2019/02/map_img_1138084_1501023103.jpg'
    file = URI.open(image_path)
    filename = File.basename(URI.parse(image_path).path)
    photo.attach(io: file, filename: filename)

    image_path = 'https://images.unsplash.com/photo-1514320291840-2e0a9bf2a9ae?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80'
    file = URI.open(image_path)
    filename = File.basename(URI.parse(image_path).path)
    banner.attach(io: file, filename: filename)
  end
end
