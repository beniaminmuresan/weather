class RenameWeatherConfigurationsTableName < ActiveRecord::Migration[7.0]
  def change
    rename_table :weather_configurations, :weather_preferences
  end
end
