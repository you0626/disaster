class SuppliesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_supply, only: [:show, :edit, :update, :destroy]

  def index
    @necessary_supplies = current_user.supplies.where(category: 'necessary').order(:name) # 必要な物
    @stock_supplies = current_user.supplies.where(category: 'stock').order(:expiration_date) # 備蓄品
    @new_supply = current_user.supplies.new # 備蓄品用
    @new_required_item = current_user.supplies.new # 必要なもの用
  end

  def create
    # どちらのフォームから送信されたかを確認
    if params[:supply][:type] == 'required_item'
      @supply = current_user.supplies.new(supply_params.merge(expiration_date: nil, category: 'necessary')) # 必要なもの用、期限を無効に
    else
      @supply = current_user.supplies.new(supply_params.merge(category: 'stock')) # 通常の備蓄品
    end
    
    if @supply.save
      redirect_to supplies_path, notice: '追加されました。'
    else
      @supplies = current_user.supplies.order(:expiration_date)
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