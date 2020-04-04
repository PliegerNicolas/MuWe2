class UserLanguage < ApplicationRecord
  belongs_to :user
  belongs_to :language

  validates :mastery, presence: true

  enum mastery: [basic: 0, conversant: 1, proficient: 2, fluent: 3, native: 4]
end
