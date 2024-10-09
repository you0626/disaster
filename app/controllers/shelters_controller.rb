require 'csv'

class SheltersController < ApplicationController
  before_action :authenticate_user!

  def index
    @shelters = current_user.shelters # 現在のユーザーの避難所を取得
  end

  def show
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

  def download_shelters
    # CSVファイルを返す処理
    csv_path = Rails.root.join('lib', 'assets', 'shelters.csv')
    send_file csv_path, type: 'text/csv', filename: 'shelters.csv'
  end

  def nearby
    latitude = params[:latitude]
    longitude = params[:longitude]

    if latitude.present? && longitude.present?
      # Geocoderを使用して、近くの避難所を検索
      @shelters = Shelter.near([latitude, longitude], 10) # 10km以内

      render json: { shelters: @shelters.map { |shelter| {
        name: shelter.name, 
        address: shelter.address, 
        distance: shelter.distance_to([latitude, longitude])
      } } }
    else
      render json: { error: '位置情報が提供されていません。' }, status: :unprocessable_entity
    end
  end

  def search
    if params[:region].present?
      @shelters = Shelter.where(region: params[:region])
    else
      @shelters = Shelter.all
    end
  end
  
  private

  def shelter_params
  params.require(:shelter).permit(:municipality_code, :facility_name, :address, :latitude, :longitude)
  end
end