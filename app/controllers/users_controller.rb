class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_user, only: [:update]
  before_action :update_user_last_login_at, if: :user_signed_in?

  def index
    @users = User.all
    if user_signed_in?
      @necessary_supplies = current_user.supplies.where(category: 'necessary').order(:name) # 必要な物
      @stock_supplies = Supply.where(category: 'stock').order('expiration_date ASC')
      @no_expiration_supplies = Supply.where(category: 'stock', expiration_date: nil)
      
      if current_user.latitude && current_user.longitude
        @nearby_notifications = DisasterNotification.near([current_user.latitude, current_user.longitude], 50) # 半径50km以内の通知
      else
        @nearby_notifications = DisasterNotification.none
      end
    else
      @nearby_notifications = DisasterNotification.none
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    if @user.save
      redirect_to @user, notice: 'ユーザーが作成されました。'
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    Rails.logger.debug(params.inspect)
    @user = User.find(user_params)
    if @user.update(user_params)
      redirect_to @user, notice: 'ユーザーが更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, notice: 'ユーザーが削除されました。'
  end

  def update_location
    if current_user.update(latitude: params[:latitude], longitude: params[:longitude])
      render json: { success: true }
    else
      render json: { success: false }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id]) # IDを正しく取得する
  end


  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name)
  end

  def update_user_last_login_at
    if user_signed_in?
      user = current_user  # current_user を変数に保存
      puts user.inspect  # user の内容を確認
      user.update_last_login_at if user.is_a?(User)  # User オブジェクトであるか確認
    end
  end
end