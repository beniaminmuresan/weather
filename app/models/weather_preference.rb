# frozen_string_literal: true

class WeatherPreference < ApplicationRecord
  validates_presence_of :short_name, :value
  validates_inclusion_of :short_name, in: %w[cold warm hot]
  validates_uniqueness_of :short_name
  validates :value, numericality: { only_integer: false }
  validates_inclusion_of :value, in: -100..70
end
