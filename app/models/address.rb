class Address < ApplicationRecord
  belongs_to :profile, optional: true
  belongs_to :jam, optional: true
end
