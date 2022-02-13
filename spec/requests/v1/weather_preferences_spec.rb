# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'v1/weather_preferences', type: :request do
  path '/v1/weather_preferences' do
    get('list weather_preferences') do
      tags 'Weather Preference'
      response(200, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        let(:id) { FactoryBot.create(:weather_preference).id }

        run_test!
      end
    end
  end

  path '/v1/weather_preferences/{id}' do
    parameter name: :id, in: :path, type: :string, description: 'id'
    parameter name: :weather_preference, in: :body, schema: {
      type: :object,
      properties: {
        value: { type: :number }
      },
      required: ['value']
    }

    patch('update weather_preference') do
      tags 'Weather Preference'
      response(200, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        let(:id) { FactoryBot.create(:weather_preference).id }
        let(:weather_preference) { { value: 23 } }
        run_test!
      end

      response(404, 'weather preference not found') do
        let(:id) { 'invalid' }
        let(:weather_preference) { { value: 12 } }
        run_test!
      end
    end
  end
end
