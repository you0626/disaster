class ChangeDefaultForLastLoginAtInUsers < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :last_login_at, nil
  end
end
