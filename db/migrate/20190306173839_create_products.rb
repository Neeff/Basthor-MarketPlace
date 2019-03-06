class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price, precision: 8, scale: 2
      t.integer :stock
      t.text :description
      t.references :shop, foreign_key: true

      t.timestamps
    end
  end
end
