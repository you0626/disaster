class AddDetailsToShelters < ActiveRecord::Migration[7.0]
  def change
    add_column :shelters, :phone_number, :string
    add_column :shelters, :open_hours, :string
    add_column :shelters, :facilities, :text
    add_column :shelters, :accessibility, :string
    add_column :shelters, :images, :text
  end
end
