class Jam < ApplicationRecord
  after_create :add_default_participant

  belongs_to :user
  has_one :address
  belongs_to :music_style, optional: true
  has_many :participants
  has_one :chat
  has_one_attached :photo

  validates :max_participants, :status, :start_date_time, :duration, presence: true

  enum status: { pending: 0, ongoing: 1, finished: 2 }

  def add_default_participant
    participants.create!(user: current_user, status: 1)
  end
end
