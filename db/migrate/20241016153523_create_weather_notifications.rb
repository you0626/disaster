class CreateWeatherNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :weather_notifications do |t|
      t.string :title
      t.text :content
      t.datetime :fetched_at

      t.timestamps
    end
  end
end
