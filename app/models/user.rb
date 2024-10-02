class User < ApplicationRecord
  before_create :set_last_login_at
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :friendships
  has_many :friends, through: :friendships
  has_many :posts
  has_many :disaster_notifications
  has_many :shelters
  has_many :supplies

  
  def set_last_login_at
    self.last_login_at = Time.current
  end

  def update_last_login_at
    update(last_login_at: Time.current)
  end
end