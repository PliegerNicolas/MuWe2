class Jam < ApplicationRecord
  after_create :add_default_participant, :attach_default_jam_photo

  belongs_to :user
  has_one :address
  belongs_to :music_style, optional: true
  has_many :participants, dependent: :destroy
  has_one :chat
  has_one_attached :photo

  validates :max_participants, :status, :start_date, :start_time, :duration, :end_time, :music_style, presence: true

  enum status: { planned: 0, ongoing: 1, finished: 2 }

  scope :filter_by_periode_uniq, ->(periode) { where('start_date = ?', periode) }
  scope :filter_by_periode_multiple, ->(periodes) { where('start_date BETWEEN ? AND ?', periodes[0], periodes[1]) }
  scope :filter_by_time, ->(time_periode) { where('start_time >= ? AND end_time <= ?', time_periode[0], time_periode[1]) }
  scope :filter_by_start_time, ->(start_time) {  where('start_time >= ?', start_time)}
  scope :filter_by_end_time, ->(end_time) {  where('end_time <= ?', end_time)}
  scope :filter_by_max_participants, ->(max_participants) { where('max_participants <= ?', max_participants) }
  scope :filter_by_status, ->(status) { where(status: status) }
  scope :filter_by_duo_status, ->(status_multiple) { where(status: status_multiple) }

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
