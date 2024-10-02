class UsersController < ApplicationController
  def index
    @users = User.all  # データベースから全ユーザーを取得
  end

  def show
    @user = User.find(params[:id])  # 特定のユーザーを取得
  end

  # その他のアクション（create, edit, update, destroyなど）も必要に応じて追加
end