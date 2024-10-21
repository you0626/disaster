class Users::SessionsController < Devise::SessionsController
  def create
    super do |resource|
      # ユーザーが存在する場合のみ、最終ログイン日時を更新
      resource.update_last_login_at if resource.present?

      # フレンド登録時のメッセージを優先して表示するための処理
      if flash[:notice].present? && flash[:notice] == "Signed in successfully."
        flash[:notice] = nil  # 「Signed in successfully.」のメッセージをクリア
      end
    end
  end
end