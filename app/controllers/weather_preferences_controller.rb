# frozen_string_literal: true

class WeatherPreferencesController < ApplicationController
  def index
    render json: WeatherPreference.all
  end

  def update
    weather_preference = WeatherPreference.find(params[:id])
    weather_preference.update(params.permit(:value))
    render json: weather_preference
  end
end
