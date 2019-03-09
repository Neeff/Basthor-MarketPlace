class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.references :product, foreign_key: true
      t.references :shop, foreign_key: true
      t.boolean :paid, default: false
      t.boolean :dispached, default: false
      t.boolean :completed, default: false
      t.integer :quantity, default: 0
      t.decimal :price, precision: 8, scale: 2

      t.timestamps
    end
  end
end
