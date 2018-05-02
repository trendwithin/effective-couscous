class CreateMarketMonitors < ActiveRecord::Migration[5.1]
  def change
    create_table :market_monitors do |t|
      t.date :market_close_date, null: false
      t.integer :up_four_pct_daily, null: false
      t.integer :down_four_pct_daily, null: false
      t.integer :up_twenty_five_pct_quarter, null: false
      t.integer :down_twenty_five_pct_quarter, null: false
      t.integer :up_twenty_five_pct_month, null: false
      t.integer :down_twenty_five_pct_month, null: false
      t.integer :up_thirteen_pct_quarter, null: false
      t.integer :down_thirteen_pct_quarter, null: false
      t.integer :up_fifty_pct_month, null: false
      t.integer :down_fifty_pct_month, null: false
      t.integer :total_stocks, null: false
      t.text :notes

      t.timestamps
    end
    add_index :market_monitors, [:market_close_date], unique: true
  end
end
