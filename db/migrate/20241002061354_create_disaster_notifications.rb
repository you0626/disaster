class CreateDisasterNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :disaster_notifications do |t|
      t.text :message
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
