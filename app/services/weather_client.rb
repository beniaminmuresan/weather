# frozen_string_literal: true

require 'faraday'

class WeatherClient
  attr_reader :zipcode, :api_key

  def initialize(zipcode, api_key = '55b7fdf17805493199a143223212409')
    @api_key = api_key
    @zipcode = zipcode
  end

  def self.call(zipcode)
    new(zipcode).call
  end

  def call
    return parse_successful if parse_successful.present?

    parse_error
  end

  private

    def parse_successful
      country = parsed_response_body.dig(:location, :country)
      return { error_message: 'No matching location found.' } unless country == 'UK'

      forecastday = parsed_response_body.dig(:forecast, :forecastday)&.first
      { temperature_c: forecastday&.dig(:day, :maxtemp_c) }
    end

    def parse_error
      { error_message: parsed_response_body.dig(:error, :message) }
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
