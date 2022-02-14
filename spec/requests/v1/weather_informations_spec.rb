# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'v1/weather_informations', type: :request do
  path '/v1/weather_informations/search' do
    get('search weather_information') do
      tags 'Weather Information'
      parameter name: :zipcode, in: :query, type: :string
      response(200, 'successful') do
        let!(:cold) { FactoryBot.create(:weather_preference, short_name: :cold, value: 10) }
        let!(:warm) { FactoryBot.create(:weather_preference, short_name: :warm, value: 20) }
        let!(:hot) { FactoryBot.create(:weather_preference, short_name: :hot, value: 30) }
        let(:zipcode) { 'ip130sr' }

        it 'returns a valid 201 response' do |example|
          VCR.use_cassette('zipcode_exists_in_uk') do
            submit_request(example.metadata)
            assert_response_matches_metadata(example.metadata)
          end
        end
      end

      response(422, 'weather information unprocessable') do
        let(:zipcode) { '' }
        run_test!
      end
    end
  end
end
