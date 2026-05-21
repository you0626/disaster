class AddUserIdToWeatherNotifications < ActiveRecord::Migration[7.0]
  def change
    add_reference :weather_notifications, :user, null: false, foreign_key: true
  end
end
