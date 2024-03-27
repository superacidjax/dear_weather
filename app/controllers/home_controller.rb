class HomeController < ApplicationController

  def index
  end

  def get_weather
    redis = Redis.new
    location = params['query']
    results = Geocoder.search(location)
    if redis.get(results.first.postal_code)
      @weather = JSON.parse(redis.get(results.first.postal_code))
      cached = true
    else
      lat_long = results.first.coordinates
      client = OpenWeather::Client.new(
        api_key: '57c978d38dea28287b75e364fbaf5a29',
        units: 'imperial'
      )
      weather = client.current_geo(lat_long[0], lat_long[1])
    end

    @weather ||= [
      location, weather.main.temp, (weather.main.pressure/33.864).round(2),
      weather.main.feels_like, [((weather.wind.speed) * 0.868976).round(2),
                                weather.wind.deg ], weather.clouds.all,
                                weather['weather'][0].icon_uri.to_s,
                                weather['weather'][0].main]

    redis.set(results.first.postal_code, @weather.to_json) unless cached


    render :index
  end
end
