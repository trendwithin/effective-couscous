require 'test_helper'
require 'minitest/autorun'

class CreateNewSymbolsTest < ActiveSupport::TestCase
   def setup
     @params = { values: "IBM MSFT NFLX" }
     @invalid_params = { values: "IBM, MSFT1 NFLX,"}
     @single_item_params = { values: "AA Alcoa"}
     @newline_carriage_params = { values: "AA Alcoa\r\nABC Alpha Bravo" }
     @newline_params = { values: "AA Alcoa\nABC Alpha Bravo" }
   end

   def test_validate_params_format
     action = CreateNewSymbols.new(@params[:values])
     assert action.valid_data_format?
   end

   def test_invalid_params_format
     action = CreateNewSymbols.new(@invalid_params[:values])
     refute action.valid_data_format?
   end

   def test_params_to_array
     action = CreateNewSymbols.new(@params[:values])
     expected = ["IBM", "MSFT", "NFLX"]
     result = action.params_to_array
     assert_equal expected, result
   end

   def test_split_on_return_single_line
     action = CreateNewSymbols.new(@single_item_params[:values])
     expected = ['AA Alcoa']
     result = action.split_on_return
     assert_equal expected, result
   end

   def test_split_on_return_newline_carriage
     action = CreateNewSymbols.new(@newline_carriage_params[:values])
     expected = ['AA Alcoa', 'ABC Alpha Bravo']
     result = action.split_on_return
     assert_equal expected, result
   end

   def test_split__on_return_newline
     action = CreateNewSymbols.new(@newline_params[:values])
     expected = ['AA Alcoa', 'ABC Alpha Bravo']
     result = action.split_on_return
     assert_equal expected, result
   end

   def test_insertion
     action = CreateNewSymbols.new(@newline_carriage_params[:values])
     ticker_count = StockSymbol.all.count
     insert_count = action.split_on_return.count
     action.run
     new_tickers_count = StockSymbol.all.count
     assert_equal new_tickers_count, ticker_count + insert_count
   end

  def test_duplicate_stock_symbol
    ticker = stock_symbols(:one)
    action = CreateNewSymbols.new("#{ticker.ticker} #{ticker.company_name}")
    action.run
    assert_equal [ticker.ticker], action.errors
  end
end
