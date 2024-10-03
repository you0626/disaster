class AddCategoryToSupplies < ActiveRecord::Migration[7.0]
  def change
    add_column :supplies, :category, :string
  end
end
