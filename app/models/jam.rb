class Jam < ApplicationRecord
  after_create :add_default_participant, :attach_default_jam_photo

  belongs_to :user
  has_one :address
  belongs_to :music_style, optional: true
  has_many :participants, dependent: :destroy
  has_one :chat
  has_one_attached :photo

  validates :max_participants, :status, :start_date_time, :duration, :music_style, presence: true

  enum status: { planned: 0, ongoing: 1, finished: 2 }

  def add_default_participant
    participants.create!(user: user, status: 1)
  end

  def attach_default_jam_photo
    require 'open-uri'

    image_path = 'https://res.cloudinary.com/dis87nwse/image/upload/v1586260281/image_not_found.svg'
    file = URI.open(image_path)
    filename = File.basename(URI.parse(image_path).path)
    photo.attach(io: file, filename: filename) unless self.photo.attachment
  end

  def count_participants
    participants.count
  end
end
