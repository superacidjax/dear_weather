Geocoder.configure(
  lookup: :geoapify,
  api_key: 'fee296456254470f94c0da85e78a5748',
  timeout: 5,
  units: :km
)
Geocoder.configure(cache: Geocoder::CacheStore::Generic.new(Rails.cache, {}))
