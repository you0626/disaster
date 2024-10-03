class Shelter < ApplicationRecord

  validates :facility_name, presence: true  # facility_nameのバリデーション
  validates :municipality_code, presence: true  # municipality_codeのバリデーション
  validates :address, presence: true  # addressのバリデーション
  validates :latitude, presence: true, numericality: true  # latitudeのバリデーション
  validates :longitude, presence: true, numericality: true  # longitudeのバリデーション

  belongs_to :user
end