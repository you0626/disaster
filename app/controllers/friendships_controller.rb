class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def index
    @friends = current_user.friends  # ユーザーのフレンドを取得
    @search_results = []              # 検索結果を初期化
    @friendships = Friendship.where(user_id: current_user.id)
    @user = current_user
    
    # フラッシュメッセージを格納
    if flash[:notice].present? && flash[:notice] != "Signed in successfully."
      @messages = [flash[:notice]]  # メッセージがあれば配列に格納
    else
      @messages = []  # メッセージがない場合は空の配列
    end

    if params[:name].present?
      @search_results = User.where("name LIKE ?", "%#{params[:name]}%").where.not(id: current_user.id) # ユーザー名で検索
    end
    
  end

  def create
    @friendship = Friendship.new(user_id: current_user.id, friend_id: params[:friend_id])
  
    if @friendship.save
      # フレンド登録成功時のメッセージ
      @messages = Friendship.where(friend_id: current_user.id).map do |friendship|
        "#{User.find(friendship.user_id).name}さんがあなたをフレンド登録しました。"
      end
      redirect_to user_friendships_path(current_user)
    else
      flash[:alert] = "フレンド登録に失敗しました。"
      redirect_to user_friendships_path(current_user)
    end
  end

  def destroy
    friendship = Friendship.find(params[:id])
    if friendship.destroy
      flash[:notice] = "フレンドを解除しました。"
    else
      flash[:alert] = "フレンド解除に失敗しました。"
    end
    redirect_to user_friendships_path(current_user) # 適切なリダイレクト先
  end

  def search
    @user = User.find(params[:user_id]) # ユーザーを取得
    @friendships = Friendship.where(user_id: @user.id) # ユーザーのフレンドシップを取得
  
    # 名前でフレンドを検索
    if params[:name].present?
      @friends = User.where("name LIKE ?", "%#{params[:name]}%").where.not(id: current_user.id)
    else
      @friends = [] # 検索結果を空にする
    end
  
    # 既存のフレンドリストを取得
    @existing_friends = current_user.friends
  
    render :index # indexテンプレートをレンダリング
  end

  private

  def friendship_params
    params.require(:friendship).permit(:friend_id) # friend_idは友達のユーザーIDを指すと仮定
  end
end