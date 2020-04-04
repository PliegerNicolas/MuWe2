class Instrument < ApplicationRecord
  has_many :user_instruments

  validates :instrument, presence: true
end
