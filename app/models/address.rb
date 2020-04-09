class Address < ApplicationRecord
  belongs_to :profile, optional: true
  belongs_to :jam, optional: true

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
