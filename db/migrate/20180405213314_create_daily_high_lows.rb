class CreateDailyHighLows < ActiveRecord::Migration[5.1]
  def change
    create_table :daily_high_lows do |t|
      t.integer :one_month_high, null: false
      t.integer :one_month_low, null: false
      t.integer :three_month_high, null: false
      t.integer :three_month_low, null: false
      t.integer :six_month_high, null: false
      t.integer :six_month_low, null: false
      t.integer :fifty_two_week_high, null: false
      t.integer :fifty_two_week_low, null: false
      t.integer :all_time_high, null: false
      t.integer :all_time_low, null: false
      t.integer :year_to_date_high, null: false
      t.integer :year_to_date_low, null: false
      t.date :market_close_date, null: false

      t.timestamps
    end
    add_index :daily_high_lows, :market_close_date, unique: true
  end
end
