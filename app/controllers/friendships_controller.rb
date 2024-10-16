class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def index
    @friends = current_user.friends  # ユーザーのフレンドを取得
    @search_results = []              # 検索結果を初期化
    @friendships = Friendship.where(user_id: current_user.id)
    @user = current_user
    
    # メッセージをMessageモデルから取得し、最新5件を表示
    @messages = Message.where(recipient_id: @user.id).order(created_at: :desc).limit(5)

    if params[:name].present?
      @search_results = User.where("name LIKE ?", "%#{params[:name]}%").where.not(id: current_user.id) # ユーザー名で検索
    end
    
  end

  def create
    @friendship = Friendship.new(friendship_params)
    
    if @friendship.save
      # フレンド登録成功時にメッセージを送信
      Message.create(
        sender_id: current_user.id,
        recipient_id: @friendship.friend_id, # フレンド登録された相手のID
        content: "#{current_user.name}さんからフレンド登録されました"
      )
      
      redirect_to friendships_path, notice: 'フレンド登録が完了しました。'
    else
      flash.now[:alert] = "フレンド登録に失敗しました。"
      # 失敗した場合はindexを再表示
      @friends = current_user.friends
      @search_results = []
      @messages = Message.where(recipient_id: current_user.id).order(created_at: :desc).limit(5)
      render :index
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
    params.permit(:friend_id).merge(user_id: current_user.id) # friend_idは友達のユーザーIDを指すと仮定
  end
end