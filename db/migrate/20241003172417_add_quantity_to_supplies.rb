class AddQuantityToSupplies < ActiveRecord::Migration[7.0]
  def change
    add_column :supplies, :quantity, :integer
  end
end
