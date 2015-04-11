class AddProductToPurchase < ActiveRecord::Migration
  def change
    add_reference :purchases, :product, index: true
    add_foreign_key :purchases, :products
  end
end
