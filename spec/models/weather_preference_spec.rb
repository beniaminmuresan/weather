# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WeatherPreference, type: :model do
  let(:instance) { FactoryBot.create(:weather_preference) }

  subject { instance }

  it { is_expected.to validate_presence_of(:short_name) }
  it { is_expected.to validate_inclusion_of(:short_name).in_array(%w[cold warm hot]) }
  it { is_expected.to validate_presence_of(:value) }
  it { is_expected.to validate_numericality_of(:value) }
  it { is_expected.to validate_inclusion_of(:value).in_range(-100..70) }
end
