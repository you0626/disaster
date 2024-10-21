class SuppliesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_supply, only: [:show, :edit, :update, :destroy]

  def index
    # ユーザーの必要な物と備蓄品を取得し、順序を設定
    @necessary_supplies = current_user.supplies.where(category: 'necessary').order(:name) # 必要な物
    @stock_supplies = current_user.supplies.where(category: 'stock').order(:expiration_date) # 備蓄品
    @new_supply = current_user.supplies.new # 備蓄品用
    @new_required_item = current_user.supplies.new # 必要なもの用
  end

  def create
    # params[:supply]がnilでないことを確認
    if params[:supply].nil?
      redirect_to supplies_path, alert: '無効なリクエストです。'
      return
    end
  
    # どちらのフォームから送信されたかを確認
    if params[:supply][:category] == 'necessary'
      @supply = current_user.supplies.new(supply_params.merge(expiration_date: nil, category: 'necessary')) # 必要なもの用、期限を無効に
    else
      @supply = current_user.supplies.new(supply_params.merge(category: 'stock')) # 通常の備蓄品
    end
    
    if @supply.save
      redirect_to supplies_path, notice: '追加されました。'
    else
      # 必要な物と備蓄品も再取得してビューで表示する
      @necessary_supplies = current_user.supplies.where(category: 'necessary').order(:name)
      @stock_supplies = current_user.supplies.where(category: 'stock').order(:expiration_date)
      @new_supply = current_user.supplies.new # 備蓄品用
      @new_required_item = current_user.supplies.new # 必要なもの用
      render :index
    end
  end
  
  def update
    if @supply.update(supply_params)
      redirect_to supplies_path, notice: '物資が更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @supply.destroy
    redirect_to supplies_path, notice: '物資が削除されました。'
  end

  private

  def set_supply
    @supply = current_user.supplies.find(params[:id])
  end

  def supply_params
    params.require(:supply).permit(:name, :quantity, :expiration_date, :category) # カテゴリーを許可
  end
end