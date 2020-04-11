module TimeArrayHelper
  def time_array
    time_array = []
    today = Date.today.to_datetime
    tomorrow = today + 1
    min = 15.0 / (24 * 60)
    today.step(tomorrow, min){ |d| time_array << d.strftime("%H:%M") }
    return time_array.shift(time_array.count - 1)
  end
end
