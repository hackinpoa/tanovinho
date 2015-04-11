class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.references :user, index: true
      t.decimal :value, precision: 8, scale: 2

      t.timestamps null: false
    end
    add_foreign_key :purchases, :users
  end
end
