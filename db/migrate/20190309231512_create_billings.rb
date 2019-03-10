class CreateBillings < ActiveRecord::Migration[5.2]
  def change
    create_table :billings do |t|
      t.string :code
      t.string :payment_method
      t.string :currency
      t.decimal :amount, precision: 8, scale: 2
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
