class AddRegionToWeatherNotifications < ActiveRecord::Migration[7.0]
  def change
    add_column :weather_notifications, :region, :string
  end
end
