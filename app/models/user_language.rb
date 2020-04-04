class UserLanguage < ApplicationRecord
  belongs_to :user
  belongs_to :language

  validates :mastery, presence: true
  enum mastery: [native: 4, fluent: 3, proficient: 2, conversant: 1, basic: 0]
end
