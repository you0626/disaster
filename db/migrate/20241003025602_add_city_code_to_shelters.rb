class AddCityCodeToShelters < ActiveRecord::Migration[7.0]
  def change
    add_column :shelters, :city_code, :string
  end
end
