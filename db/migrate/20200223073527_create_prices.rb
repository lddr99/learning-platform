class CreatePrices < ActiveRecord::Migration[6.0]
  def change
    create_table :prices do |t|
      t.integer :course_id, null: false
      t.integer :currency_id, null: false
      t.decimal :price, null: false

      t.timestamps
    end
  end
end
