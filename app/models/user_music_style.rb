class UserMusicStyle < ApplicationRecord
  belongs_to :user
  belongs_to :music_style
end
