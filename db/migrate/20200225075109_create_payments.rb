class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.integer :subscription_id, null: false
      t.integer :currency_id, null: false
      t.decimal :amount, null: false

      t.timestamps
    end
  end
end
