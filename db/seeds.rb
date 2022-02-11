# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

temperature = 10
%w(cold warm hot).each do |short_name|
  weather_preference = WeatherPreference.find_or_initialize_by(short_name: short_name)
  weather_preference.value = temperature
  weather_preference.save
  temperature += 10
end