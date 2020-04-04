class Language < ApplicationRecord
  has_many :user_languages

  validates :language, presence: true
end
