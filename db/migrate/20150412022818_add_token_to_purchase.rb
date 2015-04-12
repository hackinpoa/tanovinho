class AddTokenToPurchase < ActiveRecord::Migration
  def change
    add_column :purchases, :token, :string
  end
end
