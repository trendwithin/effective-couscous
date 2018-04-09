require 'test_helper'
require 'json'
require 'parse_stock_symbols'


module DataServer
  module ParseSymbols
    class ParseNyseStockSymbolsTest < ActiveSupport::TestCase
      def setup
        VCR.use_cassette('nyse_listed_stocks') do
          nyse_url = 'http://datasrv.ddfplus.com/names/nyse.txt'
          @parse_symbols = Object.new
          @parse_symbols.extend(DataServer::ParseSymbols)
          @page = @parse_symbols.fetch_url nyse_url
          @response_body = @parse_symbols.parse_response_body @page
        end
      end

      def test_response_code_200
       assert_equal '200', @page.code
      end

      def test_response_body_returns_a_string
        assert_equal String, @response_body.class
      end

      def test_parsing_response_body_on_newline
        array = @parse_symbols.split_response_on_newline @response_body
        assert_equal Array, array.class
      end

      def test_split_response_on_new_line
        page_format = "A:Agilent Technologies\r\nAA:Alcoa Corp\r\nAAC:Aac Holdings Inc\r\n"
        expected = ["A:Agilent Technologies", "AA:Alcoa Corp", "AAC:Aac Holdings Inc"]
        result = @parse_symbols.split_response_on_newline page_format
        assert_equal expected, result
      end

      def test_array_of_symbols_count_meets_expected
        expected = 3156
        result = @parse_symbols.split_response_on_newline @response_body
        assert_equal 3156, result.count
      end

      def test_split_symbols_on_colon
        pre_formated = ["A:Agilent Technologies"]
        expected = ["A Agilent Technologies"]
        result = @parse_symbols.gsub_colon_for_space pre_formated
        assert_equal expected, result
      end

      def test_split_symbols_on_colon_on_multiple_array_items
      pre_formated = ["A:Agilient Technologies", "AA:Alcoa Corp", "AAC:Aac Holdings Inc"]
      expected= ["A Agilient Technologies", "AA Alcoa Corp", "AAC Aac Holdings Inc"]
      result = @parse_symbols.gsub_colon_for_space pre_formated
      assert_equal expected, result
      end

      def test_all_stock_symbols_return_expected
        count = 2
        all_records = StockSymbol.all.count
        assert_equal count, all_records
      end

      def test_all_stock_tickers_returns_array
        all_records = StockSymbol.all
        record_one = 'XYZ'
        record_two = 'FAKE'
        result = @parse_symbols.all_stocks_symbols_to_array all_records
        assert_equal true, result.include?(record_one)
        assert_equal true, result.include?(record_two)
      end

      def test_collect_stock_symbols
        expected = ['AA:Alcoa']
        input = ['AA:Alcoa', 'XYZ:XYZ Industries', 'FAKE: Fake Company Inc.']
        results = @parse_symbols.collect_stock_symbols expected, input
        assert_equal expected, results
      end

      def test_store_stock_symbols
        input = ['AA:Alcoa']
        @parse_symbols.store_new_stocks_symbols input
        assert_equal 3, StockSymbol.all.count

        all_records = StockSymbol.all
        result = @parse_symbols.all_stocks_symbols_to_array all_records
        assert_equal true, result.include?('AA')
      end

      # I don't control incoming data- Can I assume this potential error?
      # def test_store_stock_symbols_with_empty_record
      #   input=[':Empty']
      #   @parse_symbols.store_new_stocks_symbols input
      #   assert_equal 2, StockSymbol.all.count
      # end
    end
  end
end
