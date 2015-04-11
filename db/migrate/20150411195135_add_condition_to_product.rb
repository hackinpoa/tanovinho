class AddConditionToProduct < ActiveRecord::Migration
  def change
    add_column :products, :condition, :integer
  end
end
