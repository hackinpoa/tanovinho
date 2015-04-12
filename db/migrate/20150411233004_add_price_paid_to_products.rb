class AddPricePaidToProducts < ActiveRecord::Migration
  def change
    add_column :products, :price_paid, :decimal, precision: 8, scale: 2
  end
end
