# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180409232316) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "daily_high_lows", force: :cascade do |t|
    t.integer "one_month_high", null: false
    t.integer "one_month_low", null: false
    t.integer "three_month_high", null: false
    t.integer "three_month_low", null: false
    t.integer "six_month_high", null: false
    t.integer "six_month_low", null: false
    t.integer "fifty_two_week_high", null: false
    t.integer "fifty_two_week_low", null: false
    t.integer "all_time_high", null: false
    t.integer "all_time_low", null: false
    t.integer "year_to_date_high", null: false
    t.integer "year_to_date_low", null: false
    t.date "market_close_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["market_close_date"], name: "index_daily_high_lows_on_market_close_date", unique: true
  end

  create_table "stock_price_histories", force: :cascade do |t|
    t.date "market_close_date", null: false
    t.string "ticker", null: false
    t.string "company_name"
    t.decimal "open", precision: 16, scale: 4, null: false
    t.decimal "high", precision: 16, scale: 4, null: false
    t.decimal "low", precision: 16, scale: 4, null: false
    t.decimal "close", precision: 16, scale: 4, null: false
    t.decimal "last_price", precision: 16, scale: 4, null: false
    t.decimal "percent_change", precision: 16, scale: 4, null: false
    t.decimal "net_change", precision: 16, scale: 4, null: false
    t.integer "volume", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["market_close_date", "ticker"], name: "index_stock_price_histories_on_market_close_date_and_ticker", unique: true
  end

  create_table "stock_symbols", force: :cascade do |t|
    t.string "ticker", null: false
    t.string "company_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticker"], name: "index_stock_symbols_on_ticker", unique: true
  end

end
