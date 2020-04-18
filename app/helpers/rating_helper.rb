module RatingHelper
  def average_rating(profile)
    if profile.user.ratings.empty?
      0
    else
      profile.user.ratings.average(:rating).floor
    end
  end
end
