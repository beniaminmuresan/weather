# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::WeatherInformationsController, type: :controller do
  describe 'GET #search' do
    let(:zipcode) { '' }
    let(:params) { { zipcode: zipcode } }

    subject { get :search, params: params, as: :json }

    context 'invalid zipcode provided' do
      context 'zipcode not provided' do
        it 'returns error message' do
          subject

          expect(JSON.parse(response.body)).to eq({ 'error_message' => 'Zipcode must be provided.' })
        end
      end

      context 'zipcode does not exist at all' do
        let(:zipcode) { 'zipcode' }

        it 'returns error message' do
          VCR.use_cassette('zipcode_does_not_exist_at_all') do
            subject

            expect(JSON.parse(response.body)).to eq({ 'error_message' => 'No matching location found.' })
          end
        end
      end
    end

    context 'valid zipcode provided' do
      context 'zipcode from UK' do
        let(:zipcode) { 'ip130sr' }

        it 'renders temperature' do
          VCR.use_cassette('zipcode_exists_in_uk') do
            subject

            expect(JSON.parse(response.body)).to eq({ 'temperature_c' => 7.3 })
          end
        end
      end

      context 'zipcode not from UK' do
        let(:zipcode) { '111' }

        it 'renders error message' do
          VCR.use_cassette('zipcode_does_not_exist_in_uk') do
            subject

            expect(JSON.parse(response.body)).to eq({ 'error_message' => 'Zipcode not valid in UK.' })
          end
        end
      end
    end
  end
end
