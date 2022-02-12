# frozen_string_literal: true

class WeatherInformationsController < ApplicationController
  def search
    zipcode = params.permit(:zipcode)[:zipcode]
    render json: WeatherClient.call(zipcode)
  end
end
