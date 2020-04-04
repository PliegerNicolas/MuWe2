class MusicStyle < ApplicationRecord
  has_many :user_music_styles
  has_many :jams

  validates :music_style, presence: true
end
