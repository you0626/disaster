class SheltersController < ApplicationController
  before_action :authenticate_user!

  def index
    @shelters = current_user.shelters
  end

  def show
    @shelter = current_user.shelters.find(params[:id])
  end

  def new
    @shelter = current_user.shelters.new
  end

  def create
    @shelter = current_user.shelters.new(shelter_params)
    if @shelter.save
      redirect_to @shelter, notice: '避難所が作成されました。'
    else
      render :new
    end
  end

  def edit
    @shelter = current_user.shelters.find(params[:id])
  end

  def update
    @shelter = current_user.shelters.find(params[:id])
    if @shelter.update(shelter_params)
      redirect_to @shelter, notice: '避難所が更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @shelter = current_user.shelters.find(params[:id])
    @shelter.destroy
    redirect_to shelters_path, notice: '避難所が削除されました。'
  end

  private

  def shelter_params
    params.require(:shelter).permit(:name, :location, :capacity, :description)
  end
end