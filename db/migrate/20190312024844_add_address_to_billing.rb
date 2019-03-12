class AddAddressToBilling < ActiveRecord::Migration[5.2]
  def change
    add_column :billings, :address, :string
  end
end
