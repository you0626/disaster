class Users::SessionsController < Devise::SessionsController
  def create
    super
    current_user.update_last_login_at if current_user
  end
end