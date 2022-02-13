# frozen_string_literal: true

module V1
  class WeatherPreferencesController < ApplicationController
    def index
      render json: WeatherPreference.all
    end

    def update
      weather_preference = WeatherPreference.find(params[:id])
      weather_preference.update(weather_preference_update_params)
      render json: weather_preference
    end

    private

      def weather_preference_update_params
        params.require(:weather_preference).permit(:value)
      end
  end
end
