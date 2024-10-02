class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def index
    @friendships = current_user.friendships
  end

  def create
    @friendship = current_user.friendships.new(friendship_params)
    if @friendship.save
      redirect_to friendships_path, notice: '友達リクエストが送信されました。'
    else
      redirect_to friendships_path, alert: '友達リクエストの送信に失敗しました。'
    end
  end

  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy
    redirect_to friendships_path, notice: '友達関係が削除されました。'
  end

  private

  def friendship_params
    params.require(:friendship).permit(:friend_id) # friend_idは友達のユーザーIDを指すと仮定
  end
end