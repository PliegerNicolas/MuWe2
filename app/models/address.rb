class Address < ApplicationRecord
  after_validation :geocode, if: :will_save_change_to_address?
  after_validation :reverse_geocode

  belongs_to :profile, optional: true
  belongs_to :jam, optional: true

  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude
end
