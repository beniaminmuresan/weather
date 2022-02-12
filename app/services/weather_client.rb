# frozen_string_literal: true

require 'faraday'

class WeatherClient
  attr_reader :zipcode, :api_key

  def initialize(zipcode, api_key = ENV['WEATHER_API_KEY'])
    @api_key = api_key
    @zipcode = zipcode
  end

  def self.call(zipcode)
    new(zipcode).call
  end

  def call
    return { error_message: 'Zipcode must be provided.' } unless zipcode.present?
    return { error_message: 'Zipcode not valid in UK.' } if country.present? && country != 'UK'
    return { error_message: error_message } if error_message.present?

    forecastday = parsed_response_body.dig(:forecast, :forecastday)&.first
    { temperature_c: forecastday&.dig(:day, :maxtemp_c) }
  end

  private

    def country
      parsed_response_body.dig(:location, :country)
    end

    def error_message
      parsed_response_body.dig(:error, :message)
    end

    def parsed_response_body
      @parsed_response_body ||= response_body.deep_symbolize_keys
    end

    def response_body
      faraday_connection = Faraday.new(weather_api_url) do |f|
        f.request :json
        f.response :json
        f.adapter :net_http
      end
      faraday_connection.get('', key: api_key, q: zipcode, days: 0).body
    end

    def weather_api_url
      'https://api.weatherapi.com/v1/forecast.json'
    end
end
