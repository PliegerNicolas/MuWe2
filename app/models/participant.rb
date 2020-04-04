class Participant < ApplicationRecord
  belongs_to :user
  belongs_to :jam
  has_many :ratings

  validates :status, presence: true
  enum status: [postulating: 0, accepted: 1, denied: 2, spectator: 3]
end
