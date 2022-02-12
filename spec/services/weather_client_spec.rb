# frozen_string_literal: true

RSpec.describe WeatherClient do
  let(:zipcode) { '' }
  let(:subject) { WeatherClient.new(zipcode) }

  describe '#call' do
    context 'zipcode not provided' do
      it 'returns error message' do
        result = subject.call
        expect(result).to eq({ error_message: 'Zipcode must be provided.' })
      end
    end

    context 'zipcode matching countries other than UK' do
      let(:zipcode) { '111' }

      it 'returns error message' do
        VCR.use_cassette('zipcode_does_not_exist_in_uk') do
          result = subject.call
          expect(result).to eq({ error_message: 'Zipcode not valid in UK.' })
        end
      end
    end

    context 'zipcode does not exist at all' do
      let(:zipcode) { 'zipcode' }

      it 'returns error message' do
        VCR.use_cassette('zipcode_does_not_exist_at_all') do
          result = subject.call
          expect(result).to eq({ error_message: 'No matching location found.' })
        end
      end
    end

    context 'zipcode exists in UK' do
      let(:zipcode) { 'ip130sr' }

      it 'returns the temperature matching the zipcode\'s location' do
        VCR.use_cassette('zipcode_exists_in_uk') do
          result = subject.call
          expect(result).to eq({ temperature_c: 7.3 })
        end
      end
    end
  end
end
