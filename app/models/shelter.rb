class Shelter < ApplicationRecord

  geocoded_by :address   # 住所を基に緯度・経度を取得
  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }

  validates :facility_name, presence: true  # facility_nameのバリデーション
  validates :municipality_code, presence: true  # municipality_codeのバリデーション
  validates :address, presence: true  # addressのバリデーション
  validates :latitude, presence: true, numericality: true  # latitudeのバリデーション
  validates :longitude, presence: true, numericality: true  # longitudeのバリデーション

  belongs_to :user
end