require 'csv'

class SheltersController < ApplicationController
  before_action :authenticate_user!

  def index
    @shelters = current_user.shelters # 現在のユーザーの避難所を取得
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

  def import
    file_path = Rails.root.join('lib', 'assets', 'shelters.csv')
  
    begin
      shelters = []
      CSV.foreach(file_path, headers: true, encoding: 'UTF-8') do |row|
        Rails.logger.info "Importing row: #{row.inspect}" # デバッグ用
        shelter = {
          municipality_code: row['市町村コード'],
          facility_name: row['施設・場所名'],
          address: row['住所'],
          latitude: row['緯度'],
          longitude: row['経度']
        }
  
        shelters << shelter
      end
  
      Rails.logger.info "Imported shelters: #{shelters.inspect}" # デバッグ用
      render :import # インポートビューを表示
    rescue CSV::InvalidEncodingError => e
      redirect_to shelters_path, alert: "CSVファイルのエンコーディングに問題があります: #{e.message}"
    end
  end

  private

def shelter_params
  params.require(:shelter).permit(:municipality_code, :facility_name, :address, :latitude, :longitude)
end
end