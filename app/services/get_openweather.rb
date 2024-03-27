class GetOpenweather
  def self.call(coordinates, postal_code, address)
    weather = $weather_client.current_geo(coordinates[0], coordinates[1])
    weather = [
      address, weather.main.temp, (weather.main.pressure/33.864).round(2),
      weather.main.feels_like, [((weather.wind.speed) * 0.868976).round(2),
                                weather.wind.deg ], weather.clouds.all,
                                weather['weather'][0].icon_uri.to_s,
                                weather['weather'][0].main, DateTime.now.to_i,
                                weather.main.temp_min, weather.main.temp_max]
    $redis.set(postal_code, weather.to_json)
    weather
  end
end
