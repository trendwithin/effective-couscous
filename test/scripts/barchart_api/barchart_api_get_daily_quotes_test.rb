require './test/test_helper'
require 'barchart_api_connect'
require 'barchart_api_parser'

module Barchart
  module BarchartApiConnect
    class BarchartApiParserGetQuoteTest < ActiveSupport::TestCase
      def setup
        VCR.use_cassette('api_get_daily_quotes') do
          url = "https://marketdata.websol.barchart.com/getQuote.json?apikey=" +
                ENV['barchart_api_key'] + "&symbols=AAPL,GOOG"

          @api_connection = Object.new
          @api_connection.extend(Barchart::BarchartApiConnect)
          @page = @api_connection.fetch_url url
          @response_body = @api_connection.parse_response_body(@page)
        end
      end

      def test_response_code_200
        assert_equal '200', @page.code
        assert_equal 200, @response_body['status']['code']
        assert_equal 'Success.', @response_body['status']['message']
      end

      def test_response_body_keys
        expected = ['status', 'results']
        keys = @response_body.keys
        assert_equal expected, keys
      end

      def test_resonse_body_returns_price_history_of_goog_and_aapl
        expected = ['AAPL', 'GOOG']
        @response_body['results'].map do |elem|
          assert_equal true, expected.include?(elem['symbol'])
        end
      end

      def test_parse_returned_api_data_format
        expected =
          {
          market_close_date: DateTime.now.strftime("%d-%m-%Y"),
          ticker: "AAPL",
          company_name: "Apple Inc",
          open: 171.98,
          high: 173.92,
          low: 171.73,
          close: 0,
          last_price: 173.14,
          percent_change: -0.06,
          net_change: -0.11,
          volume: 1000975
          }

        obj = {}
        @response_body['results'].map do |elem|
          obj = elem if elem['symbol'] == 'AAPL'
        end
        result = Barchart::BarchartApiParser.parse_data_from_api_response obj
        assert_equal expected, result
      end

      def test_validation_error
        record = @response_body['results'].first
        record['open'] = nil
        malformed_record = { "results" => [record] }
        result = Barchart::BarchartApiParser.map_response_and_return_formatted_record malformed_record
        assert_equal 1, result[:errors]
        assert_equal 0, result[:success]
      end

      def test_uniquness_violation
        record = @response_body['results'].first
        duplicate = { "results" => [record] }
        Barchart::BarchartApiParser.map_response_and_return_formatted_record duplicate
        duplicate = Barchart::BarchartApiParser.map_response_and_return_formatted_record duplicate
        assert_equal 1, duplicate[:errors]
      end
    end
  end
end
