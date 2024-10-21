class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_messages, only: [:index, :create, :search]

  def index
    @friends = current_user.friends
    @search_results = []
    @friendships = Friendship.where(user_id: current_user.id)
    @user = current_user

    if params[:name].present?
      @search_results = User.where("name LIKE ?", "%#{params[:name]}%").where.not(id: current_user.id)
    end
  end

  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    
    if @friendship.save
      Message.create(
        sender_id: current_user.id,
        recipient_id: @friendship.friend_id,
        content: "#{current_user.name}さんからフレンド登録されました"
      )
      redirect_back fallback_location: root_path
    else
      flash.now[:alert] = "フレンド登録に失敗しました。"
      @friends = current_user.friends
      @search_results = []
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
    redirect_back fallback_location: root_path
  end

  def search
    @user = User.find(params[:user_id])
    @friendships = Friendship.where(user_id: @user.id)
  
    if params[:name].present?
      @friends = User.where("name LIKE ?", "%#{params[:name]}%").where.not(id: current_user.id)
    else
      @friends = []
    end
  
    @existing_friends = current_user.friends
    render :index
  end

  private

  def friendship_params
    params.permit(:friend_id).merge(user_id: current_user.id)
  end

  def set_messages
    @messages = Message.where(recipient_id: current_user.id).order(created_at: :desc).limit(5)
  end
end