class RenamePriceToAmountInPriceTable < ActiveRecord::Migration[6.0]
  def change
    rename_column :prices, :price, :amount
  end
end
