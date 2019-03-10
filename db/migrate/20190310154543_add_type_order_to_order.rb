class AddTypeOrderToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :type_order, :string, default: 'last order'
  end
end
