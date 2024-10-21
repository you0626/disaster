class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validate :friend_name_present

  private

  def friend_name_present
    if friend.nil? || friend.name.blank?
      errors.add(:friend, '名前を入力してください。')
    end
  end
end