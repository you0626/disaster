class DisasterNotification < ApplicationRecord
  belongs_to :user
  validates :title, :content, :disaster_type, :latitude, :longitude, presence: true

  # Geocoderによる緯度・経度の設定
  geocoded_by :location  # もしlocationを住所として扱う場合
  reverse_geocoded_by :latitude, :longitude # 緯度と経度がすでにテーブルにある場合

  # 住所や座標の変更があった際に緯度・経度を更新
  after_validation :geocode, if: ->(obj){ obj.location.present? and obj.location_changed? }
end