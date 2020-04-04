class Chat < ApplicationRecord
  belongs_to :jam
  belongs_to :message
end
