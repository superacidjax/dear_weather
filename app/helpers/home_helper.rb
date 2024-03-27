module HomeHelper

  def weather_age(weather)
    age = DateTime.now.to_i - weather[8]
    #this gives the approximate minutes old of the report
    age/60
  end
end
