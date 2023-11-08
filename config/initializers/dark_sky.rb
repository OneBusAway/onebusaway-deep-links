$dark_sky_client = if Rails.env.test?
  DarkSky.new('fake_key')
else
  DarkSky.new(Rails.application.credentials.dig(:pirate_weather_api_key))
end