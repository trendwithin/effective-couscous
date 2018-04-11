class CreateStockPriceHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :stock_price_histories do |t|
      t.date :market_close_date, null: false
      t.string :ticker, null: false
      t.string :company_name
      t.decimal :open, null: false, :precision => 16, :scale => 4
      t.decimal :high, null: false, :precision => 16, :scale => 4
      t.decimal :low, null: false, :precision => 16, :scale => 4
      t.decimal :close, null: false, :precision => 16, :scale => 4
      t.decimal :last_price, null: false, :precision => 16, :scale => 4
      t.decimal :percent_change, null: false, :precision => 16, :scale => 4
      t.decimal :net_change, null: false, :precision => 16, :scale => 4
      t.integer :volume, null: false

      t.timestamps
    end
      add_index :stock_price_histories, [:market_close_date, :ticker], unique: true
  end
end
