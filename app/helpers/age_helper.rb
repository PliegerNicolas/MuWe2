module AgeHelper
  def age(birth_date)
    ((Time.zone.now - birth_date.to_time) / 1.year.seconds).floor.to_s + " years old" if birth_date
  end
end
