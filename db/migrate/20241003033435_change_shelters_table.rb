class ChangeSheltersTable < ActiveRecord::Migration[7.0]
  def change
    # カラムの名前変更
    rename_column :shelters, :name, :facility_name
    rename_column :shelters, :city_code, :municipality_code
    
    # 新しいカラムの追加
    add_column :shelters, :address, :string
    add_column :shelters, :latitude, :float
    add_column :shelters, :longitude, :float

    # 不要なカラムの削除
    remove_column :shelters, :location, :string
    remove_column :shelters, :description, :text
    remove_column :shelters, :phone_number, :string
    remove_column :shelters, :open_hours, :string
    remove_column :shelters, :facilities, :string
    remove_column :shelters, :accessibility, :string
    remove_column :shelters, :images, :string
  end
end
