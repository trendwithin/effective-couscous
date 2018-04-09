class CreateStockSymbols < ActiveRecord::Migration[5.1]
  def change
    create_table :stock_symbols do |t|
      t.string :ticker, null: false
      t.string :company_name

      t.timestamps
    end
    add_index :stock_symbols, :ticker, unique: true
  end
end
