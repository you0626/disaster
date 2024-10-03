class AddLatitudeAndLongitudeToDisasterNotifications < ActiveRecord::Migration[7.0]
  def change
    add_column :disaster_notifications, :latitude, :float
    add_column :disaster_notifications, :longitude, :float
  end
end
