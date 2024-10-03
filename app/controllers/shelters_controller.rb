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
    CSV.foreach(Rails.root.join('lib', 'assets', 'shelters.csv'), headers: true) do |row|
      municipality_code = row['municipality_code']&.strip
      facility_name = row['facility_name']&.strip
      address = row['address']&.strip
      latitude = row['latitude']&.to_f
      longitude = row['longitude']&.to_f
  
      if municipality_code.nil? || facility_name.nil? || address.nil? || latitude.nil? || longitude.nil?
        puts "Skipping row due to missing data: #{row.inspect}"
        next
      end
  
      Shelter.create!(
        municipality_code: municipality_code,
        name: facility_name,
        location: address,
        latitude: latitude,
        longitude: longitude
      )
    end
    redirect_to shelters_path, notice: '避難所データをインポートしました。'
  end

  private

  def shelter_params
    params.require(:shelter).permit(:name, :location, :capacity, :description)
  end
end