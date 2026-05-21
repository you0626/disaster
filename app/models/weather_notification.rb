class WeatherNotification < ApplicationRecord
  belongs_to :user, optional: true
  validates :title, :content, :fetched_at, presence: true

  # 発行日時の範囲で通知を取得するスコープ
  scope :recent, -> { where('fetched_at > ?', 1.week.ago) }
end