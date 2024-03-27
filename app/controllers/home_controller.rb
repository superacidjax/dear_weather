class HomeController < ApplicationController

  def index
  end

  def get_weather
    results = get_location(params['query'])
    @weather = get_cached_weather_for(results.first.postal_code)
    @weather ||= GetOpenweather.call(results.first.coordinates,
                                   results.first.postal_code, params['query'])
    render :index
  end

  private

  def get_location(query)
    Geocoder.search(query)
  end

  def get_cached_weather_for(postal_code)
    weather = JSON.parse($redis.get(postal_code)) if $redis.get(postal_code)
    if weather.present? && (DateTime.now.to_i - weather[8]) < 1800
      @cached = true
      weather
    end
  end

end
