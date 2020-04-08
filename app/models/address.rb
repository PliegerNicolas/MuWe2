class Address < ApplicationRecord
  after_validation :geocode, if: :will_save_change_to_given_address?
  after_validation :reverse_geocode

  belongs_to :profile, optional: true
  belongs_to :jam, optional: true

  geocoded_by :given_address
  reverse_geocoded_by :latitude, :longitude, address: :given_address

  def display_address
    if latitude && longitude
      if street.exists?
        "#{street}, #{postal_code}, #{city}, #{country}"
      else
        given_address
      end
    else
      "'#{given_address}' hasn't been found"
    end
  end
end
