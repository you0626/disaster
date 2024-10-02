class User < ApplicationRecord
  # Devise モジュール
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :friendships
  has_many :friends, through: :friendships
  has_many :posts
  has_many :disaster_notifications
  has_many :shelters
  has_many :supplies
end