class AddStatusToPurchase < ActiveRecord::Migration
  def change
    add_column :purchases, :status, :string
  end
end
