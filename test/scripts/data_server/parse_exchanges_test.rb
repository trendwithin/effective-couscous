require './test/test_helper'
require 'json'
require 'parse_stock_symbols'

module DataServer
  module ParseSymbols
    class ParseExchangeStockSymbolsTest < ActiveSupport::TestCase
      def setup
        VCR.use_cassette('extract_exchange_listed_stocks') do
          nyse_url = 'http://datasrv.ddfplus.com/names/nyse.txt'
          amex_url = 'http://datasrv.ddfplus.com/names/amex.txt'
          nasdaq_url = 'http://datasrv.ddfplus.com/names/nasd.txt'
          @parse_symbols = Object.new
          @parse_symbols.extend(DataServer::ParseSymbols)
          @nyse = @parse_symbols.fetch_url nyse_url
          @amex = @parse_symbols.fetch_url amex_url
          @nasdaq = @parse_symbols.fetch_url nasdaq_url
          @nyse_body = @parse_symbols.parse_response_body @nyse
          @amex_body = @parse_symbols.parse_response_body @amex
          @nasdaq_body = @parse_symbols.parse_response_body @nasdaq
        end
      end

      def test_split_response_on_new_line
        page_format = "A:Agilent Technologies\r\nAA:Alcoa Corp\r\nAAC:Aac Holdings Inc\r\n"
        expected = ["A:Agilent Technologies", "AA:Alcoa Corp", "AAC:Aac Holdings Inc"]
        result = @parse_symbols.split_response_on_newline page_format
        assert_equal expected, result
      end

      def test_for_duplicate_records
        nyse = DataServer::ParseSymbols.split_response_on_newline @nyse_body
        amex = DataServer::ParseSymbols.split_response_on_newline @amex_body
        nasdaq = DataServer::ParseSymbols.split_response_on_newline @nasdaq_body
        pruned_list = DataServer::ParseSymbols.prune_duplicates_from_source nyse, amex, nasdaq
      end

      def test_duplicates
        nyse = ["AAAP:Advanced Accele. Ads"]
        amex = nyse
        nasdaq = amex
        pruned_list = DataServer::ParseSymbols.prune_duplicates_from_source nyse, amex, nasdaq
        assert_equal ["AAAP:Advanced Accele. Ads"], pruned_list
      end

      def test_duplicates_with_non_duplicate_record
        nyse = ["AAAP:Advanced Accele. Ads"]
        amex = nyse
        nasdaq = ["AAAP:Advanced Accele. Ads", "RAND:Random Company"]
        pruned_list = DataServer::ParseSymbols.prune_duplicates_from_source nyse, amex, nasdaq
        assert_equal ["AAAP:Advanced Accele. Ads", "RAND:Random Company"], pruned_list
      end

      def test_convert_data_to_colon_separated_values
        record = stock_symbols(:one)
        expected = "#{record.ticker}:#{record.company_name}"
        result = DataServer::ParseSymbols.colon_separated_value record
        assert_equal expected, result
      end

      def test_prune_duplicates_from_model
        record = stock_symbols(:one)
        all_symbols = DataServer::ParseSymbols.all_stock_symbols
        formatted = "#{record.ticker}:#{record.company_name}"
        data = ["AAAP:Advanced Accele. Ads", "RAND:Random Company"] << formatted
        expected = ["AAAP:Advanced Accele. Ads", "RAND:Random Company"]
        result = DataServer::ParseSymbols.prune_duplicates_from_model data, all_symbols
        assert_equal expected, result
      end

      def test_prune_duplicates_empty_table
        empty_table = StockSymbol.none.to_a
        expected = ["AAAP:Advanced Accele. Ads", "RAND:Random Company"]
        result = DataServer::ParseSymbols.prune_duplicates_from_model expected, empty_table
        assert_equal expected, result
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

      def test_multiple_spaced_company_names_insert_correctly
        formatted_input = ["AAC Aac Holdings Inc"]
        expected = "Aac Holdings Inc"
        @parse_symbols.store_new_stocks_symbols formatted_input
        record = StockSymbol.find_by_ticker "AAC"
        assert_equal expected, record.company_name

      end

      def test_store_stock_symbols
        input = ['AA:Alcoa']
        formatted_input = @parse_symbols.gsub_colon_for_space input
        @parse_symbols.store_new_stocks_symbols formatted_input
        assert_equal 3, StockSymbol.all.count

        all_records = StockSymbol.all
        result = @parse_symbols.all_stocks_symbols_to_array all_records
        assert_equal true, result.include?('AA')
      end

      # def test_prune_duplicates_from_model
      #   # all_symbols = @parse_symbols.all_stock_symbols
      #   list = ["AAAP:Advanced Accele. Ads", "RAND:Random Company", "FAKE:Fake Company Inc."]
      #   all_records = Data
      #   expected = ["AAAP:Advanced Accele. Ads", "RAND:Random Company"]
      #   returned = DataServer::ParseSymbols.unique_records list
      # end
    end
  end
end
