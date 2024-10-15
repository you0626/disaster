class Users::SessionsController < Devise::SessionsController
  def create
    super do |resource|
      # ユーザーが存在する場合のみ、最終ログイン日時を更新
      current_user.update_last_login_at if current_user

      # フレンド登録時のメッセージを優先して表示するための処理
      if flash[:notice].present? && flash[:notice] == "Signed in successfully."
        flash[:notice] = nil  # 「Signed in successfully.」のメッセージをクリア
      end
    end
  end
end