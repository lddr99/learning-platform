class CreateCurrencies < ActiveRecord::Migration[6.0]
  def change
    create_table :currencies do |t|
      t.string :name, precision: 20, scale: 2, null: false

      t.timestamps
    end
  end
end
