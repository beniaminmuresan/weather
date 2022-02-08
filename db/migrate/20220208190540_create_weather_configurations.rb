class CreateWeatherConfigurations < ActiveRecord::Migration[7.0]
  def change
    create_table :weather_configurations do |t|
      t.string :short_name
      t.decimal :value, precision: 4, scale: 2

      t.timestamps
    end
  end
end
