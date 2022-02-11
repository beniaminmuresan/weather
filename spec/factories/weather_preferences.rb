# frozen_string_literal: true

FactoryBot.define do
  factory :weather_preference, class: 'WeatherPreference' do
    short_name { :hot }
    value { 30.5 }
  end
end
