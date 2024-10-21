class User < ApplicationRecord
  before_create :set_last_login_at
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :trackable

  has_many :friendships
  has_many :friends, through: :friendships
  has_many :posts
  has_many :disaster_notifications
  has_many :shelters, class_name: 'Shelter'
  has_many :supplies
  has_many :sent_messages, class_name: "Message", foreign_key: "sender_id"
  has_many :received_messages, class_name: "Message", foreign_key: "recipient_id"

  geocoded_by :current_sign_in_ip do |obj, results|
    if geo = results.first
      obj.latitude = geo.latitude
      obj.longitude = geo.longitude
    end
  end

  after_validation :geocode, if: :current_sign_in_ip_changed?

  # バリデーションの設定
  validates :name, presence: true, uniqueness: { case_sensitive: false }  # 名前は必須で一意
  validates :email, presence: true, uniqueness: { case_sensitive: false } # メールアドレスは必須で一意
  validates :password, presence: true # パスワードは必須

  def set_last_login_at
    self.last_login_at = Time.current
  end

  def update_last_login_at
    update(last_login_at: Time.current)
  end
end