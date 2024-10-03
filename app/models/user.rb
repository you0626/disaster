class User < ApplicationRecord
  before_create :set_last_login_at
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :trackable

  has_many :friendships
  has_many :friends, through: :friendships
  has_many :posts
  has_many :disaster_notifications
  has_many :shelters, class_name: 'Shelter'
  has_many :supplies

  geocoded_by :current_sign_in_ip do |obj, results|
    if geo = results.first
      obj.latitude = geo.latitude
      obj.longitude = geo.longitude
    end
  end

  after_validation :geocode, if: :current_sign_in_ip_changed?

  
  def set_last_login_at
    self.last_login_at = Time.current
  end

  def update_last_login_at
    update(last_login_at: Time.current)
  end
end