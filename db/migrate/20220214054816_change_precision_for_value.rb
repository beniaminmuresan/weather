class ChangePrecisionForValue < ActiveRecord::Migration[7.0]
  def change
    change_column :weather_preferences, :value, :decimal, precision: 4, scale: 2
  end
end
