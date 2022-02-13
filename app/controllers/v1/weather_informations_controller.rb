# frozen_string_literal: true

module V1
  class WeatherInformationsController < ApplicationController
    def search
      response = WeatherClient.call(search_params[:zipcode])

      if response[:error_message].present?
        render json: response, status: :unprocessable_entity
      else
        render json: response
      end
    end

    private

      def search_params
        params.permit(:zipcode)
      end
  end
end
