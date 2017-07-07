class ChangeColumnInChefs < ActiveRecord::Migration[5.1]
  def change
    rename_column :chefs, :chef_name, :chefname
  end
end
