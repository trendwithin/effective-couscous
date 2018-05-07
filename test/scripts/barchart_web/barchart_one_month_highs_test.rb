require './test/test_helper'
require 'json'
require 'barchart_data_parser'
require 'api_connect'

module Barchart
  module BarchartDataParser
    class BarchartDataParserNewMonthlyHighsTest < ActiveSupport::TestCase
      def setup
        VCR.use_cassette('one_month_highs') do
          url = <<~HEREDOC.gsub(/^[\s\t]*|[\s\t]*\n/, '').strip
          https://core-api.barchart.com/v1/quotes/get?lists=stocks.highslows.current.
          highs.1m.us&fields=symbol%2CsymbolName%2ClastPrice%2CpriceChange%2CpercentChange%
          2Cvolume%2ChighHits1m%2ChighPercent1m%2ClowPercent1m%2CtradeTime%2CsymbolCode%
          2CsymbolType%2ChasOptions&meta=field.shortName%2Cfield.type%2Cfield.description
          &hasOptions=true&raw=1
          HEREDOC

          @data_parser = Object.new
          @data_parser.extend(Barchart::BarchartDataParser)
          @api_connection = ApiConnect.new(url)
          @page = @api_connection.fetch_page_body
          @response_body = @api_connection.parse_page_response_body
        end
      end

      # Test and Validate Returned JSON with VCR (return data fragile)
      def test_response_code_200
       assert_equal '200', @page.code
      end

      def test_api_response_keys
        expected = ["count", "total", "data", "meta", "errors"]
        response_keys = @response_body.keys
        assert_equal expected, response_keys
      end

      def test_expected_count_matches_returned_count
        expected = 428
        count = @response_body['count']
        assert_equal expected, count
      end

      def test_expected_total_matches_returned_total
        expected = 428
        total = @response_body['total']
        assert_equal expected, total
      end

      def test_first_middle_last_returned_symbol_matches_expected
        expected_stock_symbols = [['AAT'], ["LPTX"], ["ZUMZ"]]
        all_stock_symbols = []
        selected_stock_symbols = []
        @response_body['data'].each { |hash| all_stock_symbols << hash.values_at("symbol") }
        selected_stock_symbols << all_stock_symbols.first
        selected_stock_symbols << all_stock_symbols[all_stock_symbols.count / 2]
        selected_stock_symbols << all_stock_symbols.last
        assert_equal expected_stock_symbols, selected_stock_symbols
      end

      # Overlap and redundancy with API validation is intentional
      def test_parse_response_body_returns_expected_format
        response_body_to_json = @data_parser.parse_response_body(@page)
        assert_equal Hash, response_body_to_json.class
      end

      def test_parse_count_returns_expected_count
        expected_count = 428
        count = @data_parser.parse_count @response_body
        assert_equal expected_count, count
      end

      def test_parse_total_returns_expected_total
        expected_total = 428
        total = @data_parser.parse_total @response_body
        assert_equal expected_total, total
      end

      def test_parse_body_data
        expected = @response_body['data']
        result = @data_parser.parse_data @response_body
        assert_equal expected, result
      end

      def test_parse_stock_symbols
        expected_stock_symbols = [['AAT'], ["LPTX"], ["ZUMZ"]]
        selected_stock_symbols = []
        body = @data_parser.parse_data @response_body
        all_stock_symbols = @data_parser.parse_stock_symbols body
        selected_stock_symbols << all_stock_symbols.first
        selected_stock_symbols << all_stock_symbols[all_stock_symbols.count / 2]
        selected_stock_symbols << all_stock_symbols.last
        assert_equal expected_stock_symbols, selected_stock_symbols
      end
    end
  end
end
