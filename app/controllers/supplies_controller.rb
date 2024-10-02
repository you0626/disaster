class SuppliesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_supply, only: [:show, :edit, :update, :destroy]

  def index
    @supplies = current_user.supplies
  end

  def new
    @supply = current_user.supplies.new
  end

  def create
    @supply = current_user.supplies.new(supply_params)
    if @supply.save
      redirect_to supplies_path, notice: '物資が追加されました。'
    else
      render :new
    end
  end

  def show
  end

  def edit
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
    params.require(:supply).permit(:name, :quantity, :expiration_date) # name、quantity、expiration_dateなど必要な属性を追加
  end
​⬤