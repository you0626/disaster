class AddDetailsToDisasterNotifications < ActiveRecord::Migration[7.0]
  def change
    add_column :disaster_notifications, :title, :string
    add_column :disaster_notifications, :occurred_at, :datetime
    add_column :disaster_notifications, :magnitude, :float
    add_column :disaster_notifications, :max_intensity, :string
    add_column :disaster_notifications, :location, :string
  end
end