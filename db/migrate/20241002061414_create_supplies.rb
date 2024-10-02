class CreateSupplies < ActiveRecord::Migration[7.0]
  def change
    create_table :supplies do |t|
      t.string :name
      t.date :expiration_date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
