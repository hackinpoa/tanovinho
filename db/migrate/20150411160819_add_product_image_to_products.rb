class AddProductImageToProducts < ActiveRecord::Migration
  def change
    add_column :products, :product_image_id, :string
  end
end
