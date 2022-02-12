# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WeatherPreferencesController, type: :controller do
  describe 'GET #index' do
    subject { get :index, params: {}, as: :json }

    let!(:weather_preference_1) { FactoryBot.create(:weather_preference, short_name: :cold) }
    let!(:weather_preference_2) { FactoryBot.create(:weather_preference, short_name: :warm) }
    let!(:weather_preference_3) { FactoryBot.create(:weather_preference, short_name: :hot) }

    let(:expected_response_body) do
      [
        { 'id' => weather_preference_1.id, 'short_name' => 'cold', 'value' => weather_preference_1.value.to_s },
        { 'id' => weather_preference_2.id, 'short_name' => 'warm', 'value' => weather_preference_2.value.to_s },
        { 'id' => weather_preference_3.id, 'short_name' => 'hot', 'value' => weather_preference_3.value.to_s }
      ]
    end

    it 'renders all weather preferences' do
      subject

      expect(JSON.parse(response.body)).to eq(expected_response_body)
    end
  end

  describe 'GET #update' do
    subject { patch :update, params: { value: new_value, id: weather_preference.id }, as: :json }

    let!(:weather_preference) { FactoryBot.create(:weather_preference, value: 12) }
    let(:new_value) { '15.4' }

    let(:expected_response_body) do
      { 'id' => weather_preference.id, 'short_name' => weather_preference.short_name, 'value' => new_value }
    end

    it 'renders the updated weather preferences' do
      subject

      expect(JSON.parse(response.body)).to eq(expected_response_body)
    end
  end
end
